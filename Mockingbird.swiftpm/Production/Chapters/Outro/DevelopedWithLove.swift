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
    @State var geomtryHolder: GeometryProxy?
    
    @State var canTransition: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            HStack {
                FontText(text: "Developed with", size: 64)
                    .multilineTextAlignment(.center)
                    .padding()
                
                GeometryReader { geometry in
                    Button(action: {
                        if let circlePosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                            ParticleView.spawnParticle(xpos: circlePosition.x, ypos: circlePosition.y)
                        }
                    }) {
                        Image("SF_heart_white_bcg")
                            .interpolation(.high)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .glow(color: Color("MainYellow").opacity(0.25), radius: 30)
                    }
                    .buttonStyle(NoOpacityButtonStyle())
                    .onAppear(){
                        geomtryHolder = geometry

                        DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
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
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                canTransition = true
            }
        }
        .gesture(
            TapGesture()
                .onEnded {
                    performTransition()
                }
                .exclusively(before: DragGesture()
                    .onEnded { value in
                        if value.translation.height < 0 {
                            performTransition()
                        }
                    }
                )
        )
    }
    
    func performTransition(){
        if !canTransition{
            return
        }
        
        transitionManagerObservable.transitionToScene?(1)
    }
}

#Preview {
    LayersManager(initialView: DevelopedWithLove())
}
