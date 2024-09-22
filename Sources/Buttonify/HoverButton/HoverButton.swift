//
//  HoverButton.swift
//
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import SwiftUI


public struct HoverButton<Content: View>: View {
    // MARK: - Properties

    @Environment(\.buttonStyles) private var styles: Styles
    
    private let content: Content
    private let hapticConfig: HapticConfiguration?
    private let interactionCallback: (InteractionType) -> Void
    private let resetDelay: TimeInterval
    private let holdingThreshold: TimeInterval
    private let isShrinkable: Bool
    
    private var isLarge: Bool {
        styles.isLarge
    }
    
    @Binding private var isLoading: Bool
    @State private var isPressed = false
    @State private var interactionType: InteractionType = .none
    @State private var holdTimer: Timer?

    // MARK: - Initializer

    public init(
        isLoading: Binding<Bool> = .constant(false),
        isShrinkable: Bool = false,
        hapticConfig: HapticConfiguration? = nil,
        resetDelay: TimeInterval = 0.5,
        holdingThreshold: TimeInterval = 0.25,
        @ViewBuilder content: () -> Content,
        interactionCallback: @escaping (InteractionType) -> Void
    ) {
        self._isLoading = isLoading
        self.isShrinkable = isShrinkable
        self.hapticConfig = hapticConfig
        self.resetDelay = resetDelay
        self.holdingThreshold = holdingThreshold
        self.content = content()
        self.interactionCallback = interactionCallback
    }

    public var body: some View {
        HStack {
            if styles.isLarge && (!isShrinkable || !isLoading) {
                Spacer()
            }
            
            ZStack {
                if isLoading {
                    ProgressView()
                        .transition(
                            .asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom))
                            .combined(with: .opacity)
                        )
                } else {
                    content
                        .transition(
                            .asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom))
                            .combined(with: .opacity)
                        )
                }
            }
            .padding(isLarge ? 10 : 0)
            .animation(.easeInOut(duration: 0.3), value: isLoading)
            
            if styles.isLarge && (!isShrinkable || !isLoading) {
                Spacer()
            }
        }
        .contentShape(Rectangle())  // Make the entire area tappable
        .gesture(mainGesture)
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
        triggerHapticIfNeeded(hapticConfig?.tap)
        resetInteractionTypeWithDelay()
    }
    
    private func handleHolding() {
        interactionType = .holding
        interactionCallback(.holding)
        triggerHapticIfNeeded(hapticConfig?.longPress)
        // Continue holding until the finger is lifted
    }
    
    private func handleRelease() {
        interactionType = .released
        interactionCallback(.released)
        triggerHapticIfNeeded(hapticConfig?.tap)
        resetInteractionTypeWithDelay()
    }

    // MARK: - Haptic Feedback

    private func triggerHapticIfNeeded(_ hapticType: HapticType?) {
        guard let hapticType = hapticType else { return }
        HapticManager.shared.generate(hapticType)
    }

    // MARK: - Interaction Reset

    private func resetInteractionTypeWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + resetDelay) {
            interactionType = .none
            interactionCallback(.none)
            //triggerHapticIfNeeded(releaseHapticType)
        }
    }
}

// MARK: - For Testing Purposes
extension HoverButton {
    
    // Inside HoverButton struct
    public func isShrinkableForTest() -> Bool {
        return self.isShrinkable
    }
    
    func simulateTap() {
        handleTap()
    }
    
    func simulateHold() {
        handleHolding()
    }
    
    func simulateRelease() {
        handleRelease()
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

struct HoverButtonPreviewContainer: View {
    
    @State private var interactionType: InteractionType = .none
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            HoverButton(
//                isLarge: true,
                isLoading: $isLoading,
                isShrinkable: true,
//                style: .primary(isLarge: true),
//                style: .secondary(isLarge: false),
//                style: .destroy(isLarge: true),
//                style: .roundShadow(isLarge: true),
//                style: .bordered(isLarge: true),
//                shrinkable: false,
//                isLoading: $isLoading,
                hapticConfig: HapticConfiguration(
                    tap: .impact(.light),
                    longPress: .impact(.heavy),
                    release: .selection
                )
            ) {
                Text(interactionType.description)
            } interactionCallback: { interaction in
                interactionType = interaction
                
                self.load()
            }
            .hoverButtonStyle(.primary(isLarge: true)) // Applying the custom ViewModifier

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
    HoverButtonPreviewContainer()
}
