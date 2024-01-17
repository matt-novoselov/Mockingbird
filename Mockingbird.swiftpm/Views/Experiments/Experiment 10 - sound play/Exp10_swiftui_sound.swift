//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct Exp10_swiftui_sound: View {
    var body: some View {
        VStack {
            Button("Play Sound") {
                // Call a function to play the sound
                playSound()
            }
        }
    }
}

#Preview {
    Exp10_swiftui_sound()
}
