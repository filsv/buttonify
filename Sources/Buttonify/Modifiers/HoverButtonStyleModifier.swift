//
//  File.swift
//  
//
//  Created by FIL SVIATOSLAV on 14/09/2024.
//

import Foundation
import SwiftUI

// Custom ViewModifier for HoverButton styling
public struct HoverButtonStyleModifier: ViewModifier {
    
    let style: Style
    
    private var values: Styles {
        style.values
    }
    
    private var cornerRadius: CGFloat { values.radius ?? 0 }
    private var shadowRadius: CGFloat { values.shadow?.radius ?? 0.0 }
    private var shadowColor: Color { values.shadow?.color ?? Color.clear }
    private var shadowXPos: CGFloat { values.shadow?.x ?? 0.0 }
    private var shadowYPos: CGFloat { values.shadow?.y ?? 0.0 }
    private var borderColor: Color { values.border?.color ?? Color.clear }
    private var borderWidth: CGFloat { values.border?.width ?? 0.0 }
    
    private var padding: CGFloat { values.padding ?? 0.0 }
    private var hPadding: CGFloat { values.horizontalPadding ?? 0.0 }
    
    private var tint: Color { values.tint }
    private var background: Color? { values.background }
    
    private var isLarge: Bool { values.isLarge }
    
    public func body(content: Content) -> some View {
        content
            .environment(\.buttonStyles, values) // Set the environment value here
            .tint(values.tint)
            .font(values.font)
            .padding(padding)
            .padding(.horizontal, hPadding)
            .background(background)
            .foregroundColor(tint)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
            )
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowXPos, y: shadowYPos)
            .padding(isLarge ? 10 : 0)
    }
}
