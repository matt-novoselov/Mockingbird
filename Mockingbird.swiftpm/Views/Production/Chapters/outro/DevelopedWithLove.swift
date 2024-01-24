//
//  SK_app_layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct DevelopedWithLove: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
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
                        .glow(color: Color("MainYellow").opacity(0.3), radius: 30)
                        
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                if let circlePosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
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
}

#Preview {
    LayersManager(initialView: DevelopedWithLove())
}
