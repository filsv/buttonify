//
//  HoverButton+Extensions.swift
//
//
//  Created by FIL SVIATOSLAV on 14/09/2024.
//

import SwiftUI

extension HoverButton {
    public func hoverButtonStyle(_ style: Style = .primary(isLarge: false)) -> some View {
        self.modifier(
            HoverButtonStyleModifier(style: style)
        )
    }
}

//extension HoverButton {
//    public func hoverButtonStyle(_ style: Style = .primary(isLarge: false),
//                                 isLoading: Bool = false,
//                                 shrinkable: Bool = false) -> some View {
//        HoverButtonContainer(isLarge: style.values.isLarge, 
//                             isLoading: isLoading,
//                             shrinkable: shrinkable,
//                             style: style) {
//            self
//        }
//    }
//}
