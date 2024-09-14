//
//  File.swift
//  
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import Foundation
import SwiftUI

public enum Style {
    case primary(isLarge: Bool = false)
    case secondary(isLarge: Bool = false)
    case custom(style: Styles)
    
    var value: Styles {
        switch self {
            case .primary(let isLarge):
                return .init(tint: Color.white,
                             selectedTint: Color.white.opacity(0.8),
                             font: .body,
                             radius: 5,
                             background: Color.blue,
                             hoveredBackground: Color.blue.opacity(0.9),
                             padding: 5,
                             horizontalPadding: 5,
                             shadow: nil,
                             isLarge: isLarge
                )
            case .secondary(let isLarge):
                return .init(tint: Color.gray,
                             selectedTint: Color.gray.opacity(0.8),
                             font: .body,
                             radius: 5,
                             background: Color.gray.opacity(0.1),
                             hoveredBackground: Color.gray.opacity(0.05),
                             padding: 5,
                             horizontalPadding: 5,
                             shadow: nil,
                             isLarge: isLarge
                )
        case .custom(let customStyle):
            return customStyle
        }
    }
}

public struct Styles {
    private let tint: Color
    private let selectedTint: Color?
    private let font: Font
    private let radius: CGFloat?
    private let background: Color?
    private let hoveredBackground: Color?
    private let padding: CGFloat?
    private let horizontalPadding: CGFloat?
    private let shadow: Shadow?//(Color, CGFloat, CGFloat, CGFloat) // Color, Radius, X, Y
    private let isLarge: Bool
    
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
    
    public init(tint: Color = Color.black,
         selectedTint: Color? = nil,
         font: Font = .body,
         radius: CGFloat? = nil,
         background: Color? = nil,
         hoveredBackground: Color? = nil,
         padding: CGFloat? = nil,
         horizontalPadding: CGFloat? = nil,
         shadow: Shadow? = nil,
         isLarge: Bool = false) {
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
        self.isLarge = isLarge
    }
}
