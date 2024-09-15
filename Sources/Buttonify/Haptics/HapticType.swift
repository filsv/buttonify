//
//  File.swift
//  
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

public enum HapticType {
    case impact(Intensity)
    case notification(NotificationType)
    case selection

    public enum Intensity {
        case light
        case medium
        case heavy
        case soft
        case rigid
    }

    public enum NotificationType {
        case success
        case warning
        case error
    }
}
