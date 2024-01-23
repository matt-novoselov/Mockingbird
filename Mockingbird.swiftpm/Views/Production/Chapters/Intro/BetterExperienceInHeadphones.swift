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
            
            Text("Better experience with headphones")
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        // Transition to scene
                        transitionToScene(1)
                    }
                }
        }
    }
}

#Preview {
    BetterExperienceInHeadphones(transitionToScene: TransitionManager().transitionToScene)
}
