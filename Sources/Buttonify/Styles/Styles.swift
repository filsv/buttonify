//
//  File.swift
//  
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import Foundation
import SwiftUI

public enum Style {
    case primary
    
    var value: Styles {
        switch self {
            case .primary:
            return .init(tint: Color.black, 
                         selectedTint: Color.black.opacity(0.8),
                         font: .body,
                         radius: 5,
                         background: Color.gray.opacity(0.2),
                         hoveredBackground: Color.gray.opacity(0.1),
                         padding: 5,
                         horizontalPadding: 5,
                         shadow: nil
            )
        }
    }
}

public struct Styles {
    let tint: Color
    let selectedTint: Color?
    let font: Font
    let radius: CGFloat?
    let background: Color?
    let hoveredBackground: Color?
    let padding: CGFloat?
    let horizontalPadding: CGFloat?
    let shadow: Shadow?//(Color, CGFloat, CGFloat, CGFloat) // Color, Radius, X, Y
    
    public struct Shadow {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
        
        init(color: Color = Color.clear, radius: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }
    
    init(tint: Color = Color.black,
         selectedTint: Color? = nil,
         font: Font = .body,
         radius: CGFloat? = nil,
         background: Color? = nil,
         hoveredBackground: Color? = nil,
         padding: CGFloat? = nil,
         horizontalPadding: CGFloat? = nil,
         shadow: Shadow? = nil) {
         //shadow: (Color, CGFloat, CGFloat, CGFloat) = (Color.clear, 0, 0, 0)) {
        
        self.tint = tint
        self.selectedTint = selectedTint ?? tint.opacity(0.8)
        self.font = font
        self.radius = radius
        self.background = background
        self.hoveredBackground = hoveredBackground ?? background?.opacity(0.9) ?? Color.clear
        self.padding = padding
        self.horizontalPadding = horizontalPadding
        self.shadow = shadow
    }
}
