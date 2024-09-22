import SwiftUI

// Extension to conditionally apply the tint modifier on supported macOS/iOS versions
extension View {
    @ViewBuilder
    func ifAvailableTint(_ color: Color) -> some View {
        if #available(iOS 15.0, macOS 13.0, *) {
            self.tint(color)
        } else {
            self
        }
    }
}
