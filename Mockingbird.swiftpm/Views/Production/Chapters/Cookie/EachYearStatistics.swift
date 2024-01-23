//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct EachYearStatistics: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            FontText(text: "Each year, over 10 million people die from various forms of addictions.", size: 64)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 150)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { timer in
                // Transition to scene
                transitionManagerObservable.transitionToScene?(3)
            }
        }
    }
}

#Preview {
    EachYearStatistics()
}
