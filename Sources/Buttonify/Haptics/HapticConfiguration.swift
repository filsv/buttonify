//
//  HapticConfiguration.swift
//
//
//  Created by FIL SVIATOSLAV on 15/09/2024.
//

import Foundation

public struct HapticConfiguration {
    var tap: HapticType?
    var longPress: HapticType?
    var release: HapticType?
    
    public init(tap: HapticType? = nil, longPress: HapticType? = nil, release: HapticType? = nil) {
        self.tap = tap
        self.longPress = longPress
        self.release = release
    }
}
