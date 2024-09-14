//
//  HoverButton.swift
//
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import SwiftUI

public struct HoverButton<Content: View>: View {

    private let style: Style
    private let content: Content
    private let tapHapticType: HapticType? // Haptic for tap
    private let releaseHapticType: HapticType? // Haptic for release
    private let longTapHapticType: HapticType? // Haptic for long tap
    private let interactionCallback: (InteractionType) -> Void // Callback for interaction
    private var resetDelay: TimeInterval = 0.5 // Delay to reset interaction to none

    @State private var isActive: Bool = false
    @State private var interactionType: InteractionType = .none
    @State private var longPressInProgress: Bool = false // Track long tap
    @State private var longPressTriggered: Bool = false  // Track if long press was triggered

    public init(style: Style,
                tapHapticType: HapticType? = nil,
                releaseHapticType: HapticType? = nil,
                longTapHapticType: HapticType? = nil,
                resetDelay: TimeInterval = 0.5,
                @ViewBuilder content: () -> Content,
                interactionCallback: @escaping (InteractionType) -> Void) {
        self.style = style
        self.tapHapticType = tapHapticType
        self.releaseHapticType = releaseHapticType
        self.longTapHapticType = longTapHapticType
        self.resetDelay = resetDelay
        self.content = content()
        self.interactionCallback = interactionCallback
    }

    public var body: some View {
        content
            .font(style.value.font)
            .padding(style.value.padding ?? 0)
            .padding(.horizontal, style.value.horizontalPadding ?? 0)
            .background(isActive ? style.value.background ?? Color.gray : style.value.hoveredBackground ?? Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: style.value.radius ?? 0, style: .continuous))
            .foregroundStyle(isActive ? style.value.selectedTint ?? style.value.tint : style.value.tint)
            .animation(.easeInOut(duration: 0.2), value: isActive)
            .gesture(
                SimultaneousGesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onChanged { _ in
                            handleLongPressChanged()
                        }
                        .onEnded { _ in
                            handleLongPressEnded()
                        },
                    TapGesture()
                        .onEnded {
                            handleTapEnded()
                        }
                )
            )
            .onChange(of: isActive) { _ in
                longPressInProgress = false // Reset long press tracking after interaction
            }
            .onHover { isHovering in
                self.isActive = isHovering
            }
    }

    // Long press changed logic
    private func handleLongPressChanged() {
        if !longPressInProgress {
            longPressInProgress = true
            longPressTriggered = true
            interactionType = .holding
            interactionCallback(.holding)
            triggerHapticIfNeeded(hapticType: longTapHapticType)
        }
    }

    // Long press ended logic
    private func handleLongPressEnded() {
        if longPressTriggered {
            longPressInProgress = false
            interactionType = .released
            interactionCallback(.released)
            isActive = false
            resetInteractionTypeWithDelay()
        }
    }

    // Tap ended logic
    private func handleTapEnded() {
        if !longPressInProgress && !longPressTriggered { // Ensure tap is only handled if no long press occurred
            interactionType = .tap
            interactionCallback(.tap)
            triggerHapticIfNeeded(hapticType: tapHapticType)
            isActive = true
            resetInteractionTypeWithDelay()
        }
        longPressTriggered = false // Reset long press flag after interaction
    }

    // Trigger haptic feedback if needed
    private func triggerHapticIfNeeded(hapticType: HapticType?) {
        if let haptic = hapticType {
            HapticManager.triggerHaptic(haptic)
        }
    }

    // Reset the interaction type to none with a delay
    private func resetInteractionTypeWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + resetDelay) {
            interactionType = .none
            interactionCallback(.none) // Notify the parent of the reset
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
                releaseHapticType: .selection,
                longTapHapticType: .impact(.heavy)
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
            return Color.blue
        case .released:
            return Color.green
        case .holding:
            return Color.orange
        case .none:
            return Color.gray
        }
    }
}

#Preview {
    HoverButtonContainer()
}
