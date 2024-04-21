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
    
    // Property that controls if hint should be shown
    @State var displayingHint: Bool = true
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            ZStack{
                VStack (spacing: 0){
                    Image("SF_headphones")
                        .interpolation(.high)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                    
                    FontText(text: "Better experience with headphones ", size: 64)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 100)
                }
                
                // Hint that appears after a while to help users navigate to the next scene
                TapToContinueHint(displayingHint: $displayingHint)
            }
            
            // Play initialization empty sound to awake sound manager
            .onAppear(){
                playSound(name: "Sound_Init", ext: "mp3")
            }
        }
        
        // Transition to the next scene on tap or slide
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
    
    // Function to perform transition
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
