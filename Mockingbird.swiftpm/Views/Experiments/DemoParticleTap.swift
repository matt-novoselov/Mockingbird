//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct DemoParticleTap: View {
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
        }
        .onTapGesture { tap in
            ParticleView.spawnParticle(xpos: tap.x, ypos: tap.y)
        }
    }
}

#Preview {
    ZStack{
        DemoParticleTap()
        
        SwiftuiParticles()
    }
    .ignoresSafeArea()
}
