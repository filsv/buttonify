//
//  File.swift
//  
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public protocol HapticGenerator {
    func generate(_ type: HapticType)
}

public class HapticManager: HapticGenerator {
    public static let shared = HapticManager()

    private init() {}

    public func generate(_ type: HapticType) {
        #if os(iOS)
        generateiOSHaptic(type)
        #elseif os(watchOS)
        generateWatchOSHaptic(type)
        #else
        // No-op or default implementation
        #endif
    }

    #if os(iOS)
    private func generateiOSHaptic(_ type: HapticType) {
        switch type {
        case .impact(let intensity):
            let style: UIImpactFeedbackGenerator.FeedbackStyle
            switch intensity {
            case .light: style = .light
            case .medium: style = .medium
            case .heavy: style = .heavy
            case .soft: style = .soft
            case .rigid: style = .rigid
            }
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        case .notification(let notificationType):
            let feedbackType: UINotificationFeedbackGenerator.FeedbackType
            switch notificationType {
            case .success: feedbackType = .success
            case .warning: feedbackType = .warning
            case .error: feedbackType = .error
            }
            UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
    #endif

    #if os(watchOS)
    private func generateWatchOSHaptic(_ type: HapticType) {
        // Implement watchOS haptic feedback mapping
    }
    #endif
}
