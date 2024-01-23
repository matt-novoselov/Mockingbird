//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI
import SpriteKit

struct CombinationManager: View {
    @State private var scene = ParticleLayer()
    
    var body: some View {
        ZStack {
            DevelopedWithLove(scene: $scene)
            
            SpriteView(
                scene: scene,
                options: [.allowsTransparency]
            )
            .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CombinationManager()
}
