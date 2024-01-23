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
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            Button(action: {
                withAnimation(.none) {
                    currentDisplayedImage = "PH_calendar"
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
