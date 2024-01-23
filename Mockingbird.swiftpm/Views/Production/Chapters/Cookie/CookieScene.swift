//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct CookieScene: View {
    var transitionToScene: (Int) -> Void
    
    @State var currentDisplayedImage: String = "PH_grid"
    @State var heavenSlider: Double = 0
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            Button(action: {
                withAnimation(.none) {
                    currentDisplayedImage = "PH_calendar"
                }
                
                let animationDuration = 3.0
                
                withAnimation(.easeInOut(duration: animationDuration)) {
                    heavenSlider = 0.25
                } completion: {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        heavenSlider = 0
                    }
                }
            })
            {
                Image(currentDisplayedImage)
            }
        }
    }
}

#Preview {
    CookieScene(transitionToScene: TransitionManager().transitionToScene)
}
