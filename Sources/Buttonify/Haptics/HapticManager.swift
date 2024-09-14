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

struct HapticManager {
    static func triggerHaptic(_ hapticType: HapticType) {
        #if os(iOS)
        switch hapticType {
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(type)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
        #endif
    }
}
