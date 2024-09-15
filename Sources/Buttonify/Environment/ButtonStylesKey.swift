//
//  ButtonStylesKey.swift
//  
//
//  Created by FIL SVIATOSLAV on 15/09/2024.
//

import SwiftUI

private struct ButtonStylesKey: EnvironmentKey {
    static let defaultValue: Styles = Styles()
}

extension EnvironmentValues {
    var buttonStyles: Styles {
        get { self[ButtonStylesKey.self] }
        set { self[ButtonStylesKey.self] = newValue }
    }
}
