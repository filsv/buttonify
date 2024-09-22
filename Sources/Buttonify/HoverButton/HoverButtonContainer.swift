//
//  SwiftUIView.swift
//  
//
//  Created by FIL SVIATOSLAV on 15/09/2024.
//

import SwiftUI

public struct HoverButtonContainer<Content: View>: View {
    let isLarge: Bool
    let isLoading: Bool
    let shrinkable: Bool
    let style: Style
    let content: () -> Content
    
    public init(
        isLarge: Bool = false,
        isLoading: Bool = false,
        shrinkable: Bool = false,
        style: Style = .primary(isLarge: false),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.isLarge = isLarge
        self.isLoading = isLoading
        self.shrinkable = shrinkable
        self.style = style
        self.content = content
    }
    
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
    
    public var body: some View {
        HStack {
            if isLarge && !isLoading && shrinkable {
                Spacer()
            }
            
            ZStack {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: shrinkable ? .none : (isLarge ? .infinity : nil)) // Adjust width based on shrinkable state
                        .transition(.opacity.combined(with: .scale))
                } else {
                    content()
                        .frame(maxWidth: shrinkable ? .none : (isLarge ? .infinity : nil)) // Adjust width based on shrinkable state
                        .transition(.opacity.combined(with: .scale))
                }
            }
            .padding(isLarge ? 10 : 0)
            
            if isLarge && !isLoading && shrinkable {
                Spacer()
            }
        }
        .frame(maxWidth: (shrinkable || !isLarge) ? nil : .infinity) // Ensure full width or shrinkable width
        .animation(.easeInOut(duration: 0.3), value: isLoading)
        .ifAvailableTint(style.values.tint)
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

#Preview {
    HoverButtonContainer {
        Text("Button")
    }
}
