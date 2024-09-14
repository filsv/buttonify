# Buttonify

Buttonify is a SwiftUI framework that provides customizable and reusable button components with haptic feedback and interaction tracking. It simplifies the process of building interactive and responsive buttons in SwiftUI-based applications.

## Features

- Customizable button styles.
- Supports tap, long-press, and release gestures.
- Built-in haptic feedback for interactions.
- Easily extendable for other gesture-based interactions.
- Support for interaction state callbacks.

## Requirements

- iOS 15.0+ / macOS 11.0+
- Xcode 15.0+
- Swift 5.1+

## Installation

### Swift Package Manager (Recommended)

You can add Buttonify to your project using Swift Package Manager. 

1. In Xcode, go to `File` > `Add Packages...`.
2. Enter the repository URL: 
`https://github.com/yourusername/buttonify.git`
3. Select the version or branch you want to integrate.
4. Click `Add Package`.

## Usage

### Basic Button Example

```swift
import Buttonify
import SwiftUI

struct ContentView: View {
 var body: some View {
     HoverButton(style: .primary, interactionCallback: { interaction in
         switch interaction {
         case .tap:
             print("Button tapped")
         case .holding:
             print("Button is being held")
         case .released:
             print("Button released")
         case .none:
             print("No interaction")
         }
     }) {
         Text("Press Me")
     }
 }
}
```

### Customizing Button Style
You can define your own styles for buttons, including background color, font, padding, and more.
```swift
let customStyle = Style(
    value: StyleValue(
        font: .system(size: 16, weight: .bold),
        background: Color.blue,
        hoveredBackground: Color.gray.opacity(0.2),
        selectedTint: Color.white,
        tint: Color.black,
        radius: 10,
        padding: 12,
        horizontalPadding: 20
    )
)

HoverButton(style: customStyle) {
    Text("Custom Button")
}
```
