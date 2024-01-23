//
//  SK_app_layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct DevelopedWithLove: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            HStack {
                FontText(text: "Developed with", size: 64)
                    .multilineTextAlignment(.center)
                    .padding()
                
                GeometryReader { geometry in
                    Image("SF_heart_white_bcg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .glow(color: Color("MB_main_yellow").opacity(0.3), radius: 30)
                        
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                if let circlePosition = getGlobalPosition(view: geometry) {
                                    ParticleView.spawnParticle(xpos: circlePosition.x, ypos: circlePosition.y)
                                }
                            }
                        
                        }
                }
                .frame(width: 60, height: 60)
                
                FontText(text: "by Matt Novoselov", size: 64)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { timer in
                // Transition to scene
                transitionManagerObservable.transitionToScene?(1)
            }
        }
    }
    
    private func getGlobalPosition(view: GeometryProxy) -> CGPoint? {
        let circleRect = view.frame(in: .global)
        return CGPoint(x: circleRect.midX, y: circleRect.midY)
    }
}

#Preview {
    ZStack{
        DevelopedWithLove()
        
        SwiftuiParticles()
    }
    .ignoresSafeArea()
}
