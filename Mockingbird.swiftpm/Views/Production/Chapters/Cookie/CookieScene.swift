//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct CookieScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var currentDisplayedImage: String = "PH_grid"
    @State var heavenSlider: Double = 0
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            Button(action: {
                withAnimation(.none) {
                    currentDisplayedImage = "PH_calendar"
                }
                
                notificationManager.callNotification(
                    ID: 0,
                    arrowAction: {
                        transitionManagerObservable.transitionToScene?(4)
                    }
                )
                
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
                    .interpolation(.high)
            }
            .buttonStyle(NoOpacityButtonStyle())
        }
    }
}

#Preview {
    LayersManager(initialView: CookieScene())
}
