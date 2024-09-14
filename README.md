# # Buttonify

Welcome to the **Buttonify - Lightweight SwiftUI Button Library** for SwiftUI!</br>

This library provides a customizable button component that supports different interaction states (tap, holding, release) with optional haptic feedback and a flexible styling system.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Basic Usage](#basic-usage)
  - [Customizing Styles](#customizing-styles)
  - [Handling Interactions](#handling-interactions)
  - [Haptic Feedback](#haptic-feedback)
  - [Loading State](#loading-state)
- [Customization](#customization)
  - [Styles and Themes](#styles-and-themes)
  - [Interaction Types](#interaction-types)
- [Examples](#examples)
  - [Example 1: Primary Buttons](#example-1-primary-buttons)
  - [Example 2: Loading Buttons](#example-2-loading-buttons)
  - [Example 3: Secondary Buttons](#example-3-secondary-buttons)
  - [Example 4: Shadowed Buttons](#example-4-shadowed-buttons)
  - [Example 5: Bordered Buttons](#example-5-bordered-buttons)
  - [Example 6: Custom Buttons](#example-6-custom-buttons)
- [License](#license)

## Features

- **Multiple Interaction States**: Supports tap, holding, and release states.
- **Customizable Styles**: Easily customize fonts, colors, padding, borders, shadows, and more.
- **Haptic Feedback**: Optional haptic feedback for different interaction types.
- **Loading State**: Built-in support for displaying a loading indicator.
- **Adaptive Layout**: Supports large and small button sizes.
- **Accessibility**: Designed with accessibility in mind.

## Installation

To use the Buttonify UI Library in your SwiftUI project, you have two options:

1. **Copying the Source Files**: 
   You can copy the provided source files into your project directory or include them as part of your UI components module.

2. **Swift Package Manager (SPM)**: 
   Add Buttonify to your project using SPM. 
   - Open your project in Xcode.
   - Navigate to `File > Add Packages...`.
   - Enter the repository URL of Buttonify in the search bar (use the copy button below):
     ```plaintext
     https://github.com/filsv/buttonify.git
     ```
   - Choose the package options that fit your needs and click `Add Package`. 

Once added, you can start using Buttonify in your SwiftUI project.

## Usage

### Basic Usage

Here's how you can use the `HoverButton` in your SwiftUI views:

```swift
import SwiftUI
import Buttonify

struct ContentView: View {
    @State private var interactionType: InteractionType = .none

    var body: some View {
        HoverButton(
            style: .primary(isLarge: false),
            shrinkable: false, // Added option to disable shrinking when loading
            interactionCallback: { interaction in
                interactionType = interaction
            }
        ) {
            Text("Press Me")
        }
    }
}
```

## Customizing Styles

You can customize the appearance of the HoverButton by using predefined styles or creating your own:

```swift
HoverButton(
    style: .secondary(isLarge: true),
    interactionCallback: { interaction in
        // Handle interactions
    }
) {
    Text("Secondary Button")
}
```

To create a custom style:

```swift
let customStyle = Styles(
    tint: .white,
    selectedTint: .gray,
    font: .headline,
    radius: 12,
    background: .green,
    hoveredBackground: .green.opacity(0.8),
    padding: 10,
    horizontalPadding: 20,
    border: Styles.Border(color: .white, width: 2),
    shadow: Styles.Shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2),
    isLarge: true
)

HoverButton(
    style: .custom(style: customStyle),
    interactionCallback: { interaction in
        // Handle interactions
    }
) {
    Text("Custom Button")
}
```

## Handling Interactions

The interactionCallback closure provides updates on the button’s interaction state:

```swift
 HoverButton(
    interactionCallback: { interaction in
        switch interaction {
        case .tap:
            print("Button was tapped")
        case .holding:
            print("Button is being held")
        case .released:
            print("Button was released")
        case .none:
            print("No interaction")
        }
    }
) {
    Text("Interactable Button")
}
```

## Haptic Feedback

You can enable haptic feedback for different interaction types:

```swift
HoverButton(
    tapHaptic: .impact(.light),
    longPressHaptic: .selection,
    releaseHaptic: .impact(.soft),
    interactionCallback: { interaction in
        // Handle interactions
    }
) {
    Text("Haptic Button")
}
```

## Loading State

The HoverButton supports a loading state, displaying a ProgressView when isLoading is true:

```swift
@State private var isLoading = false

HoverButton(
    isLoading: $isLoading,
    interactionCallback: { interaction in
        if interaction == .tap {
            isLoading = true
            // Simulate a network request
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
            }
        }
    }
) {
    Text("Submit")
}
```

### Customization

## Styles and Themes

The Style enum and Styles struct allow you to define the appearance of the HoverButton:

# Predefined Styles
	.primary(isLarge: Bool)
	.secondary(isLarge: Bool)
	.shadowed(isLarge: Bool)
	.bordered(isLarge: Bool)

# Custom Styles:
  	Use .custom(style: Styles) to apply it. // Create a Styles instance with your desired properties.

 ## Style Properties:
 	tint: Text color.
	selectedTint: Text color when pressed.
	font: Font style.
	radius: Corner radius.
	background: Background color.
	hoveredBackground: Background color when pressed.
	padding: Vertical padding.
	horizontalPadding: Horizontal padding.
	border: Styles.Border (color and width).
	shadow: Styles.Shadow (color, radius, x, y).
	isLarge: Adjusts the button’s size and layout.

  ## Interaction Types
  
  The InteractionType enum represents the button’s interaction states:
  	.tap: The button was tapped.
	.holding: The button is being held down.
	.released: The button was released after a hold.
	.none: No interaction (default state).

  Use the interactionCallback closure to handle these interactions in your view logic.

### Examples

Below are comprehensive examples demonstrating the use of HoverButton with different styles, interaction handling, and customizations.

# Example 1: Primary Buttons
```swift
import SwiftUI

struct PrimaryButtonsExample: View {
    @State private var interactionType: InteractionType = .none

    var body: some View {
        VStack(spacing: 20) {
            Text("Primary Buttons")
                .font(.headline)
                .padding()

            HoverButton(
                style: .primary(isLarge: true),
                tapHaptic: .impact(.light),
                longPressHaptic: .selection,
                releaseHaptic: .impact(.heavy)
            ) {
                Text("Large Primary")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            HoverButton(
                style: .primary(isLarge: false),
                tapHaptic: .impact(.light),
                longPressHaptic: .selection,
                releaseHaptic: .impact(.heavy)
            ) {
                Text("Small Primary")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            Text("Current Interaction: \(interactionType.description)")
                .padding()
        }
    }
}
```

# Example 2: Loading Buttons
```swift
import SwiftUI

struct LoadingButtonsExample: View {
    @State private var interactionType: InteractionType = .none
    @State private var isLoading: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Loading Buttons")
                .font(.headline)
                .padding()

            HoverButton(
                style: .primary(isLarge: true),
                isLoading: $isLoading,
		shrinkable: true,
                tapHaptic: .impact(.light)
            ) {
                Text(isLoading ? "Loading..." : "Large Loading")
            } interactionCallback: { interaction in
                interactionType = interaction
                if interaction == .tap {
                    initiateLoading()
                }
            }

            HoverButton(
                style: .primary(isLarge: false),
                isLoading: $isLoading,
		shrinkable: true,
                tapHaptic: .impact(.light)
            ) {
                Text(isLoading ? "Loading..." : "Small Loading")
            } interactionCallback: { interaction in
                interactionType = interaction
                if interaction == .tap {
                    initiateLoading()
                }
            }

            Text("Current Interaction: \(interactionType.description)")
                .padding()
        }
    }

    private func initiateLoading() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
        }
    }
}
```

# Example 3: Secondary Buttons
```swift
import SwiftUI

struct SecondaryButtonsExample: View {
    @State private var interactionType: InteractionType = .none

    var body: some View {
        VStack(spacing: 20) {
            Text("Secondary Buttons")
                .font(.headline)
                .padding()

            HoverButton(
                style: .secondary(isLarge: true),
                tapHaptic: .impact(.light)
            ) {
                Text("Large Secondary")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            HoverButton(
                style: .secondary(isLarge: false),
                tapHaptic: .impact(.light)
            ) {
                Text("Small Secondary")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            Text("Current Interaction: \(interactionType.description)")
                .padding()
        }
    }
}
```

# Example 4: Shadowed Buttons
```swift
import SwiftUI

struct ShadowedButtonsExample: View {
    @State private var interactionType: InteractionType = .none

    var body: some View {
        VStack(spacing: 20) {
            Text("Shadowed Buttons")
                .font(.headline)
                .padding()

            HoverButton(
                style: .shadowed(isLarge: true),
                tapHaptic: .impact(.medium)
            ) {
                Text("Large Shadowed")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            HoverButton(
                style: .shadowed(isLarge: false),
                tapHaptic: .impact(.medium)
            ) {
                Text("Small Shadowed")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            Text("Current Interaction: \(interactionType.description)")
                .padding()
        }
    }
}
```

# Example 5: Bordered Buttons
```swift
import SwiftUI

struct BorderedButtonsExample: View {
    @State private var interactionType: InteractionType = .none

    var body: some View {
        VStack(spacing: 20) {
            Text("Bordered Buttons")
                .font(.headline)
                .padding()

            HoverButton(
                style: .bordered(isLarge: true),
                tapHaptic: .selection,
                holdingThreshold: 1.0 // Holding state triggered after 1 second
            ) {
                Text("Large Bordered")
            } interactionCallback: { interaction in
                interactionType = interaction
                if interaction == .holding {
                    print("Button held for 1 second")
                }
            }

            HoverButton(
                style: .bordered(isLarge: false),
                tapHaptic: .selection,
                holdingThreshold: 1.0
            ) {
                Text("Small Bordered")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            Text("Current Interaction: \(interactionType.description)")
                .padding()
        }
    }
}
```

# Example 6: Custom Buttons
```swift
import SwiftUI

struct CustomButtonsExample: View {
    @State private var interactionType: InteractionType = .none

    var body: some View {
        VStack(spacing: 20) {
            Text("Custom Buttons")
                .font(.headline)
                .padding()

            // Custom Large Button
            let customStyleLarge = Styles(
                tint: .orange,
                selectedTint: .black,
                font: .largeTitle,
                radius: 5.0,
                background: .red,
                isLarge: true
            )

            HoverButton(
                style: .custom(style: customStyleLarge),
                tapHaptic: .impact(.heavy)
            ) {
                Text("Custom Large")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            // Custom Small Button
            let customStyleSmall = Styles(
                tint: .yellow,
                selectedTint: .black,
                font: .headline,
                radius: 5.0,
                background: .orange,
                padding: 5,
                horizontalPadding: 10,
                shadow: Styles.Shadow(color: .black, radius: 5, x: 5, y: 5),
                isLarge: false
            )

            HoverButton(
                style: .custom(style: customStyleSmall),
                tapHaptic: .impact(.light)
            ) {
                Text("Custom Small")
            } interactionCallback: { interaction in
                interactionType = interaction
            }

            Text("Current Interaction: \(interactionType.description)")
                .padding()
        }
    }
}
```

### License
This Buttonify Library is available under the MIT License. Feel free to use and modify it in your projects.
