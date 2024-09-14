//
//  HoverButton.swift
//
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import SwiftUI


public struct HoverButton<Content: View>: View {
    // MARK: - Properties

    private let style: Style
    private let content: Content
    private let tapHapticType: HapticType?
    private let longPressHapticType: HapticType?
    private let releaseHapticType: HapticType?
    private let interactionCallback: (InteractionType) -> Void
    private let resetDelay: TimeInterval
    private let holdingThreshold: TimeInterval

    @State private var isPressed = false
    @State private var interactionType: InteractionType = .none
    @State private var holdTimer: Timer?
    @Binding private var isLoading: Bool

    // MARK: - Initializer

    public init(
        style: Style = .primary(isLarge: false),
        isLoading: Binding<Bool> = .constant(false),
        tapHaptic: HapticType? = nil,
        longPressHaptic: HapticType? = nil,
        releaseHaptic: HapticType? = nil,
        resetDelay: TimeInterval = 0.5,
        holdingThreshold: TimeInterval = 0.25,
        @ViewBuilder content: () -> Content,
        interactionCallback: @escaping (InteractionType) -> Void
    ) {
        self.style = style
        _isLoading = isLoading
        self.tapHapticType = tapHaptic
        self.longPressHapticType = longPressHaptic
        self.releaseHapticType = releaseHaptic
        self.resetDelay = resetDelay
        self.holdingThreshold = holdingThreshold
        self.content = content()
        self.interactionCallback = interactionCallback
    }

    // MARK: - Body

    public var body: some View {
        HStack {
            if style.value.isLarge {
                Spacer()
            }
            
            if isLoading {
                ProgressView()
                    .tint(style.value.tint)
            } else {
                content
                    .padding(style.value.isLarge ? 10 : 0)
            }
            
            if style.value.isLarge {
                Spacer()
            }
        }
        .font(style.value.font)
        .padding(style.value.padding ?? 0.0)
        .padding(.horizontal, style.value.horizontalPadding ?? 0.0)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .clipShape(RoundedRectangle(cornerRadius: style.value.radius ?? 0.0, style: .continuous))
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .gesture(mainGesture)
    }

    // MARK: - Computed Properties

    private var backgroundColor: Color {
        let hoveredBackground = style.value.hoveredBackground ?? style.value.background ?? Color.clear
        let background = style.value.background ?? Color.clear
        return isPressed ? hoveredBackground : background
    }

    private var foregroundColor: Color {
        let pressedTint = style.value.selectedTint ?? style.value.tint
        let tint = style.value.selectedTint ?? style.value.tint
        return isPressed ? (pressedTint) : tint
    }

    
    // MARK: - Gesture
    
    private var mainGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
                if !isPressed {
                    isPressed = true
                    startHoldTimer()
                }
            }
            .onEnded { _ in
                isPressed = false
                cancelHoldTimer()
                if interactionType == .holding {
                    // If already in holding state, trigger release
                    handleRelease()
                } else {
                    // If not holding, it's a tap
                    handleTap()
                }
            }
    }
    
    // MARK: - Timer Management
    
    private func startHoldTimer() {
        holdTimer = Timer.scheduledTimer(withTimeInterval: holdingThreshold, repeats: false) { _ in
            handleHolding()
        }
    }
    
    private func cancelHoldTimer() {
        holdTimer?.invalidate()
        holdTimer = nil
    }
    
    // MARK: - Gesture Handlers
    
    private func handleTap() {
        interactionType = .tap
        interactionCallback(.tap)
        triggerHapticIfNeeded(tapHapticType)
        resetInteractionTypeWithDelay()
    }
    
    private func handleHolding() {
        interactionType = .holding
        interactionCallback(.holding)
        triggerHapticIfNeeded(longPressHapticType)
        // Continue holding until the finger is lifted
    }
    
    private func handleRelease() {
        interactionType = .released
        interactionCallback(.released)
        triggerHapticIfNeeded(releaseHapticType)
        resetInteractionTypeWithDelay()
    }

    // MARK: - Haptic Feedback

    private func triggerHapticIfNeeded(_ hapticType: HapticType?) {
        guard let hapticType = hapticType else { return }
        HapticManager.triggerHaptic(hapticType)
    }

    // MARK: - Interaction Reset

    private func resetInteractionTypeWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + resetDelay) {
            interactionType = .none
            interactionCallback(.none)
            triggerHapticIfNeeded(releaseHapticType)
        }
    }
}

// Example usage with a Text label
/*
HoverButton(style: .primary) {
    Text("Click Me")
}

// Example usage with custom content
HoverButton(style: .primary) {
    HStack {
        Image(systemName: "star.fill")
        Text("Starred")
    }
}
*/

struct HoverButtonContainer: View {
    
    @State private var interactionType: InteractionType = .none
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            HoverButton(
                style: .primary(isLarge: false),
                isLoading: $isLoading,
                tapHaptic: .impact(.light),
                longPressHaptic: .impact(.heavy),
                releaseHaptic: .selection
            ) {
                Text(interactionType.description)
//                    .font(.headline)
//                    .padding()
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, minHeight: 50)
//                    .background(interactionColor)
//                    .cornerRadius(10)
            } interactionCallback: { interaction in
                interactionType = interaction
                
                //self.load()
            }
            .padding()

            // Add additional views if needed, like a description or actions
        }
    }
    
    private func load() {
        self.isLoading = true
        
        let delay = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isLoading = false
        }
    }
    
    // Background color changes based on interaction type
    private var interactionColor: Color {
        switch interactionType {
        case .tap:
            return Color.orange
        case .holding:
            return Color.orange
        case .released:
            return Color.red
        case .none:
            return Color.blue
        }
    }
}

#Preview {
    HoverButtonContainer()
}
