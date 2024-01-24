//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 24/01/24.
//

import SwiftUI

struct NoOpacityButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .accentColor : .primary)
            .background(configuration.isPressed ? Color.clear : Color.accentColor.opacity(0.2))
            .cornerRadius(8)
            .padding()
    }
}
