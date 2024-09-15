//
//  HoverButton.swift
//
//
//  Created by FIL SVIATOSLAV on 14/09/2024.
//

import SwiftUI

extension HoverButton {
    func hoverButtonStyle(_ style: Style, isLoading: Bool = false, shrinkable: Bool) -> some View {
        self.modifier(HoverButtonStyleModifier(style: style, isLoading: isLoading, shrinkable: shrinkable))
    }
}
