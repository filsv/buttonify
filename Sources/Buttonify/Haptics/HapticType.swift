//
//  File.swift
//  
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import Foundation
#if canImport(UIKit)
import UIKit

public enum HapticType {
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(UINotificationFeedbackGenerator.FeedbackType)
    case selection
}
#endif
