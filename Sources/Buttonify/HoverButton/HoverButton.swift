//
//  HoverButton.swift
//
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import SwiftUI


public struct HoverButton<Content: View>: View {
    // MARK: - Properties

    private let content: Content
    private let tapHapticType: HapticType?
    private let longPressHapticType: HapticType?
    private let releaseHapticType: HapticType?
    private let interactionCallback: (InteractionType) -> Void
    private let resetDelay: TimeInterval
    private let holdingThreshold: TimeInterval
    private let shrinkable: Bool
    private let isLarge: Bool

    @State private var isPressed = false
    @State private var interactionType: InteractionType = .none
    @State private var holdTimer: Timer?
    @Binding private var isLoading: Bool

    // MARK: - Initializer

    public init(
        shrinkable: Bool = false,
        isLarge: Bool = false,
        isLoading: Binding<Bool> = .constant(false),
        tapHaptic: HapticType? = nil,
        longPressHaptic: HapticType? = nil,
        releaseHaptic: HapticType? = nil,
        resetDelay: TimeInterval = 0.5,
        holdingThreshold: TimeInterval = 0.25,
        @ViewBuilder content: () -> Content,
        interactionCallback: @escaping (InteractionType) -> Void
    ) {
        self.shrinkable = shrinkable
        self.isLarge = isLarge
        _isLoading = isLoading
        self.tapHapticType = tapHaptic
        self.longPressHapticType = longPressHaptic
        self.releaseHapticType = releaseHaptic
        self.resetDelay = resetDelay
        self.holdingThreshold = holdingThreshold
        self.content = content()
        self.interactionCallback = interactionCallback
    }

    public var body: some View {
        content
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
//                style: .primary(isLarge: true),
//                style: .secondary(isLarge: false),
//                style: .destroy(isLarge: true),
//                style: .roundShadow(isLarge: true),
//                style: .bordered(isLarge: true),
                shrinkable: false,
//                isLoading: $isLoading,
                tapHaptic: .impact(.light),
                longPressHaptic: .impact(.heavy),
                releaseHaptic: .selection
            ) {
                Text(interactionType.description)
            } interactionCallback: { interaction in
                interactionType = interaction
                
                self.load()
            }
            .hoverButtonStyle(.primary(isLarge: false), isLoading: isLoading, shrinkable: true) // Applying the custom ViewModifier

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
