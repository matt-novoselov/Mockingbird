//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 24/01/24.
//

import SwiftUI

// Button with no transparency effect on click
struct NoOpacityButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(
                configuration.isPressed ? 0.9 : 1.0
            )
            .animation(Animation.easeInOut(duration: 0.5), value: configuration.isPressed)
    }
}

// Button that scales up on click
struct ScaleUpButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(
                configuration.isPressed ? 1.1 : 1.0
            )
            .animation(Animation.easeInOut(duration: 0.5), value: configuration.isPressed)
    }
}
