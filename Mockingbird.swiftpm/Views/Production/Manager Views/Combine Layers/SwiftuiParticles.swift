//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI
import SpriteKit

struct SwiftuiParticles: View {
    @State private var particleGameScene = ParticleLayer()
    
    var body: some View {
        SpriteView(
            scene: particleGameScene,
            options: [.allowsTransparency]
        )
        .allowsHitTesting(false)
        .ignoresSafeArea()
    }
}

#Preview {
    SwiftuiParticles()
}
