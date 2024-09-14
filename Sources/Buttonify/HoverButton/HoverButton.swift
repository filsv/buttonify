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

    @State private var isPressed = false
    @State private var interactionType: InteractionType = .none

    // MARK: - Initializer

    public init(
        style: Style,
        tapHapticType: HapticType? = nil,
        longPressHapticType: HapticType? = nil,
        releaseHapticType: HapticType? = nil,
        resetDelay: TimeInterval = 0.5,
        @ViewBuilder content: () -> Content,
        interactionCallback: @escaping (InteractionType) -> Void
    ) {
        self.style = style
        self.tapHapticType = tapHapticType
        self.longPressHapticType = longPressHapticType
        self.releaseHapticType = releaseHapticType
        self.resetDelay = resetDelay
        self.content = content()
        self.interactionCallback = interactionCallback
    }

    // MARK: - Body

    public var body: some View {
        Button(action: {
            handleTap()
        }) {
            content
            .font(style.value.font)
            .padding(style.value.padding ?? 0.0)
            .padding(.horizontal, style.value.horizontalPadding ?? 0.0)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: style.value.radius ?? 0.0, style: .continuous))
            .animation(.easeInOut(duration: 0.2), value: isPressed)
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    handleLongPress()
                    isPressed = false
                }
        )
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


    // MARK: - Gesture Handlers

    private func handleTap() {
        interactionType = .tap
        interactionCallback(.tap)
        triggerHapticIfNeeded(tapHapticType)
        resetInteractionTypeWithDelay()
    }

    private func handleLongPress() {
        interactionType = .holding
        interactionCallback(.holding)
        triggerHapticIfNeeded(longPressHapticType)
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
    
    var body: some View {
        VStack {
            HoverButton(
                style: .primary,
                tapHapticType: .impact(.light),
                longPressHapticType: .impact(.heavy),
                releaseHapticType: .selection
            ) {
                Text(interactionType.description)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(interactionColor)
                    .cornerRadius(10)
            } interactionCallback: { interaction in
                interactionType = interaction
            }
            .padding()

            // Add additional views if needed, like a description or actions
        }
    }
    
    // Background color changes based on interaction type
    private var interactionColor: Color {
        switch interactionType {
        case .tap:
            return Color.orange
        case .holding:
            return Color.orange
        case .none:
            return Color.blue
        }
    }
}

#Preview {
    HoverButtonContainer()
}
