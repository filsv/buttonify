//
//  Style.swift
//  
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import Foundation
import SwiftUI

public enum Style {
    case primary(isLarge: Bool = false)
    case secondary(isLarge: Bool = false)
    case shadowed(isLarge: Bool = false)
    case bordered(isLarge: Bool = false)
    case destroy(isLarge: Bool = false)
    case plain(isLarge: Bool = false)
    case custom(style: Styles)
    
    var values: Styles {
        switch self {
            case .primary(let isLarge):
                return .init(tint: Color.white,
                             selectedTint: Color.white.opacity(0.8),
                             font: .body.weight(.bold),
                             radius: isLarge ? 20 : 10,
                             background: Color.blue,
                             hoveredBackground: Color.blue.opacity(0.9),
                             padding: 5,
                             horizontalPadding: 5,
                             isLarge: isLarge
                )
            case .secondary(let isLarge):
                return .init(tint: Color.black,
                             selectedTint: Color.black.opacity(0.8),
                             font: .body,
                             radius: isLarge ? 20 : 10,
                             background: Color.gray.opacity(0.2),
                             hoveredBackground: Color.gray.opacity(0.05),
                             padding: 5,
                             horizontalPadding: 5,
                             isLarge: isLarge
                )
        case .shadowed(let isLarge):
            let shadow = Styles.Shadow(color: Color.black.opacity(0.1),
                                       radius: 2,
                                       x: 0, y: 0)
            return .init(tint: Color.black,
                         selectedTint: Color.black.opacity(0.8),
                         font: .body,
                         radius: isLarge ? 20 : 10,
                         background: Color.white,
                         hoveredBackground: Color.white.opacity(0.9),
                         padding: 5,
                         horizontalPadding: 5,
                         shadow: shadow,
                         isLarge: isLarge
            )
        case .bordered(isLarge: let isLarge):
            let border = Styles.Border(color: Color.black,
                                       width: 1.0)
            return .init(tint: Color.black,
                         selectedTint: Color.black.opacity(0.8),
                         font: .body,
                         radius: isLarge ? 20 : 10,
                         background: Color.white,
                         hoveredBackground: Color.white.opacity(0.9),
                         padding: 5,
                         horizontalPadding: 5,
                         border: border,
                         isLarge: isLarge
            )
        case .destroy(let isLarge):
            return .init(tint: Color.white,
                         selectedTint: Color.white.opacity(0.8),
                         font: .body,
                         radius: isLarge ? 20 : 10,
                         background: Color.red,
                         hoveredBackground: Color.red.opacity(0.9),
                         padding: 5,
                         horizontalPadding: 5,
                         isLarge: isLarge
            )
        case .plain(let isLarge):
            return .init(tint: Color.blue,
                         selectedTint: Color.blue.opacity(0.8),
                         font: .body,
                         radius: 0,
                         background: nil,
                         hoveredBackground: nil,
                         padding: 5,
                         horizontalPadding: 5,
                         isLarge: isLarge
            )
        case .custom(let customStyle):
            return customStyle
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
    let border: Border?
    let shadow: Shadow? // Color, Radius, X, Y
    let isLarge: Bool
    
    public struct Border {
        let color: Color
        let width: CGFloat
    }
    
    public struct Shadow {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
        
        public init(color: Color = Color.clear, radius: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0) {
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
                border: Border? = nil,
         shadow: Shadow? = nil,
         isLarge: Bool = false) {
        
        self.tint = tint
        self.selectedTint = selectedTint ?? tint.opacity(0.8)
        self.font = font
        self.radius = radius
        self.background = background
        self.hoveredBackground = hoveredBackground ?? background?.opacity(0.9) ?? Color.clear
        self.padding = padding
        self.horizontalPadding = horizontalPadding
        self.border = border
        self.shadow = shadow
        self.isLarge = isLarge
    }
}
