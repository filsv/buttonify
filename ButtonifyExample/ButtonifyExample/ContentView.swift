//
//  ContentView.swift
//  ButtonifyExample
//
//  Created by FIL SVIATOSLAV on 22/09/2024.
//

import SwiftUI
import Buttonify

struct Section<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                Spacer()
            }
            
            content
        }
        .padding(.horizontal)
    }
}

enum ButtonType: String, CaseIterable, Identifiable {
    case primary,
         secondary,
         loading,
         shadow,
         bordered,
         custom
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    @State private var interactionType: InteractionType = .none
    @State private var isLoading: Bool = false
    
    @State private var type: ButtonType = .primary
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $type) {
                    Section(title: "Primary") {
                        HoverButton(
                            isShrinkable: true,
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .impact(.medium),
                                                              release: .impact(.rigid))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.primary(isLarge: true))
                        
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.primary(isLarge: false))
                    }
                    .tag(ButtonType.primary)
                    
                    Section(title: "Secondary") {
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.secondary(isLarge: true))
                        
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.secondary(isLarge: false))
                    }
                    .tag(ButtonType.secondary)
                    
                    Section(title: "Loading") {
                        HoverButton(
                            isLoading: $isLoading,
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                            initiateLoading()
                        }
                        .hoverButtonStyle(.primary(isLarge: true))
                        
                        HoverButton(
                            isLoading: $isLoading,
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                            initiateLoading()
                        }
                        .hoverButtonStyle(.primary(isLarge: false))
                    }
                    .tag(ButtonType.loading)
                    
                    Section(title: "Shadow") {
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.shadowed(isLarge: true))
                        
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.shadowed(isLarge: false))
                    }
                    .tag(ButtonType.shadow)
                    
                    Section(title: "Bordered") {
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.bordered(isLarge: true))
                        
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.bordered(isLarge: false))
                    }
                    .tag(ButtonType.bordered)
                    
                    Section(title: "Custom") {
                        let customStyle: Styles = .init(tint: .orange,
                                                        selectedTint: .black,
                                                        font: .largeTitle,
                                                        radius: 5.0,
                                                        background: .red,
                                                        isLarge: true)
                        
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.custom(style: customStyle))
                        
                        let customStyleSmall: Styles = .init(tint: .yellow,
                                                             selectedTint: .black,
                                                             font: .largeTitle,
                                                             radius: 5.0,
                                                             background: .orange,
                                                             padding: 5,
                                                             horizontalPadding: 10,
                                                             shadow: Styles.Shadow(color: .black, radius: 5, x: 5, y: 5),
                                                             isLarge: false)
                        
                        HoverButton(
                            hapticConfig: HapticConfiguration(tap: .impact(.light),
                                                              longPress: .selection,
                                                              release: .impact(.heavy))
                        ) {
                            Text(interactionType.description)
                        } interactionCallback: { interaction in
                            interactionType = interaction
                        }
                        .hoverButtonStyle(.custom(style: customStyleSmall))
                    }
                    .tag(ButtonType.custom)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Style the TabView as a sliding tab
                .animation(.easeInOut(duration: 0.3), value: type) // Animate the selection
                
                Section(title: "Select Type") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1)) // Add background here
                            .frame(height: 50) // Optional height adjustment

                        Picker(selection: $type) {
                            ForEach(ButtonType.allCases) { type in
                                Text(type.rawValue.capitalized) // Display button type as text
                                    .tag(type) // Tag each option with its corresponding enum case
                            }
                        } label: {
                            HStack {
                                Text("Button Style")
                                Image(systemName: "chevron.up.chevron.down")
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.blue)
                        .padding(.horizontal, 10) // Padding inside picker
                    }
                    .frame(height: 50) // Adjust frame size if needed
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Buttonify Example")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    VStack(alignment: .center) {
                        Text(interactionType.description)
                            .font(.subheadline.weight(.semibold))
                        Text("Button Status")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
    
    private func initiateLoading() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isLoading = false
        }
    }
    
    // Background color changes based on interaction type
    private var interactionColor: Color {
        switch interactionType {
        case .tap:
            return Color.orange
        case .holding:
            return Color.green
        case .released:
            return Color.red
        case .none:
            return Color.blue
        }
    }
}


#Preview {
    ContentView()
}
