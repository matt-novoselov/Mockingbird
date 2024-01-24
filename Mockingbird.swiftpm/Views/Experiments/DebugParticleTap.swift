//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct DebugParticleTap: View {
    var body: some View {
        ZStack {
            HStack{
                LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))

                VStack{
                    LayerMixingManager(darkSlider: .constant(1), heavenSlider: .constant(0))
                    
                    LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(1))
                }
            }
        }
        .onTapGesture { tap in
            ParticleView.spawnParticle(xpos: tap.x, ypos: tap.y)
        }
    }
}

#Preview {
    LayersManager(initialView: DebugParticleTap())
}
