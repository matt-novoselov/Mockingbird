//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct BetterExperienceInHeadphones: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            VStack (spacing: 0){
                Image("SF_headphones")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                
                FontText(text: "Better experience with headphones ", size: 64)
                    .multilineTextAlignment(.center)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                            // Transition to scene
                            transitionToScene(1)
                        }
                    }
                    .padding()
            }

        }
    }
}

#Preview {
    BetterExperienceInHeadphones(transitionToScene: TransitionManager().transitionToScene)
}
