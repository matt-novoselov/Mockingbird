//
//  CustomColors.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 10/01/24.
//

import SwiftUI

extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color{
        return Color(red: r/255, green: g/255, blue: b/255)
    }
}

// Custom colors go here
extension Color {
    static var MBgreenColor = rgb(r: 217, g: 237, b: 191)
}
