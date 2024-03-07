//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct BetterExperienceInLandscape: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var displayingHint: Bool = true
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            ZStack{
                VStack (spacing: 0){
                    Image("SF_orientation")
                        .interpolation(.high)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 95)
                        .rotationEffect(Angle(degrees: 90))
                    
                    FontText(text: "Better experience in the landscape mode", size: 64)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 100)
                }
                
                TapToContinueHint(displayingHint: $displayingHint)
            }
            .onAppear(){
                playSound(name: "Sound_Init", ext: "mp3")
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
        withAnimation(.easeInOut(duration: 1.0)){
            displayingHint = false
        }
        transitionManagerObservable.transitionToScene?(1)
    }
}

#Preview {
    LayersManager(initialView: BetterExperienceInLandscape())
}
