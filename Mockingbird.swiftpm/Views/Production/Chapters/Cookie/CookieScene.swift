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
    
    @State var heavenSlider: Double = 0
    @State var countBites: Int = 0
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            HStack{
                Cookie(countBites: $countBites, heavenSlider: $heavenSlider)
                    .environmentObject(notificationManager)
                    .environmentObject(transitionManagerObservable)
                
                Cookie(countBites: $countBites, heavenSlider: $heavenSlider)
                    .environmentObject(notificationManager)
                    .environmentObject(transitionManagerObservable)
                
                Cookie(countBites: $countBites, heavenSlider: $heavenSlider)
                    .environmentObject(notificationManager)
                    .environmentObject(transitionManagerObservable)
            }
            .padding()
            
        }
    }
}

struct Cookie: View {
    @State var currentDisplayedImage: String = "PH_grid"
    @Binding var countBites: Int
    @Binding var heavenSlider: Double
    @State var isBitten: Bool = false
    
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        Button(action: {
            if !notificationManager.isTextPrintFinished{
                return
            }
            
            if isBitten{
                return
            }
            
            isBitten = true
            
            notificationManager.closeNotification()
            
            withAnimation(.none) {
                currentDisplayedImage = "PH_calendar"
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (countBites == 0 ? 0 : NotificationTextBlob().animationMoveInDuration + 0.1)) {
                
                if countBites != 2{
                    notificationManager.callNotification(
                        ID: countBites
                    )
                }
                else{
                    notificationManager.callNotification(
                        ID: countBites,
                        arrowAction: {
                            transitionManagerObservable.transitionToScene?(4)
                        }
                    )
                }

                
                countBites+=1
                
                let animationDuration = 3.0
                
                withAnimation(.easeInOut(duration: animationDuration)) {
                    heavenSlider = 0.25
                } completion: {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        heavenSlider = 0
                    }
                }
            }
            
        })
        {
            Image(currentDisplayedImage)
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .buttonStyle(NoOpacityButtonStyle())
    }
}

#Preview {
    LayersManager(initialView: CookieScene())
}
