//
//  File.swift
//  
//
//  Created by FIL SVIATOSLAV on 13/09/2024.
//

import Foundation

public enum InteractionType {
    case tap
    case holding
    case released
    case none
    
    public var description: String {
        switch self {
        case .tap:
            return "Tapped"
        case .released:
            return "Released"
        case .holding:
            return "Holding"
        case .none:
            return "Ready"
        }
    }
}
