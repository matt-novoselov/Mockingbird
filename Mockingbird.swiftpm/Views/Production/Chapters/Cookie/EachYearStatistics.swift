//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct EachYearStatistics: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            FontText(text: "Each year, over 10 million people die from various forms of addictions.", size: 64)
                .multilineTextAlignment(.center)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { timer in
                        // Transition to scene
                        transitionToScene(3)
                    }
                }
                .padding(.horizontal, 150)
        }
    }
}

#Preview {
    EachYearStatistics(transitionToScene: TransitionManager().transitionToScene)
}
