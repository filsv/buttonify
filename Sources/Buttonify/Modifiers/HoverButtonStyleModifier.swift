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
    let isLoading: Bool
    let shrinkable: Bool
    
    private var cornerRadius: CGFloat {
        style.values.radius ?? 0
    }

    private var shadowRadius: CGFloat {
        style.values.shadow?.radius ?? 0.0
    }
    private var shadowColor: Color {
        style.values.shadow?.color ?? Color.clear
    }
    private var shadowXPos: CGFloat {
        style.values.shadow?.x ?? 0.0
    }
    private var shadowYPos: CGFloat {
        style.values.shadow?.y ?? 0.0
    }

    private var borderColor: Color {
        style.values.border?.color ?? Color.clear
    }
    private var borderWidth: CGFloat {
        style.values.border?.width ?? 0.0
    }
    
    private var isLarge: Bool {
        style.values.isLarge
    }
    
    public func body(content: Content) -> some View {
        HStack {
            if style.values.isLarge && !isLoading && shrinkable {
                Spacer()
            }
            
            ZStack {
                if isLoading {
                    ProgressView()
                        .transition(
                            .asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom))
                            .combined(with: .opacity)
                        )
                        .frame(maxWidth: (shrinkable && isLoading) ? nil : (isLarge ? .infinity : nil)) // Grow back when not loading
                } else {
                    content
                        .transition(
                            .asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom))
                            .combined(with: .opacity)
                        )
                        .frame(maxWidth: (shrinkable && isLoading) ? nil : (isLarge ? .infinity : nil)) // Grow back when not loading
                }
            }
            .padding(isLarge ? 10 : 0)
            .animation(.easeInOut(duration: 0.3), value: isLoading)
            
            if style.values.isLarge && !isLoading && shrinkable {
                Spacer()
            }
        }
        .frame(maxWidth: shrinkable ? nil : .infinity) // Ensure full width or shrinkable width
        .animation(.easeInOut(duration: 0.3), value: isLoading)
        .tint(style.values.tint)
        .font(style.values.font)
        .padding(style.values.padding ?? 0)
        .padding(.horizontal, style.values.horizontalPadding ?? 0)
        .background(style.values.background)
        .foregroundColor(style.values.tint)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(borderColor, lineWidth: borderWidth)
        )
        .shadow(color: shadowColor, radius: shadowRadius, x: shadowXPos, y: shadowYPos)
        .padding(isLarge ? 10 : 0)
    }
}
