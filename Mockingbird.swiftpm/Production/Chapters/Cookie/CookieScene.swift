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
            
            VStack{
                HStack{
                    Cookie(countBites: $countBites, heavenSlider: $heavenSlider)
                    
                    Cookie(countBites: $countBites, heavenSlider: $heavenSlider)

                }
                
                Cookie(countBites: $countBites, heavenSlider: $heavenSlider)
            }
            .environmentObject(notificationManager)
            .environmentObject(transitionManagerObservable)
            .padding(.all, 100)
            
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
    
    @State var geomtryHolder: GeometryProxy?
    
    var body: some View {
        Button(action: {
            if !notificationManager.isTextPrintFinished{
                return
            }
            
            if isBitten{
                return
            }
            
            isBitten = true
            
            if let geometryHolder = geomtryHolder,
               let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometryHolder) {
                ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
            }
            
            notificationManager.closeNotification()
            
            withAnimation(.none) {
                currentDisplayedImage = "PH_calendar"
            }
            
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
            
        })
        {
            Image(currentDisplayedImage)
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(
                    GeometryReader{ geometry in
                        Color.clear
                            .onAppear(){
                                geomtryHolder = geometry
                            }
                    }
                )
        }
        .buttonStyle(NoOpacityButtonStyle())
    }
}

#Preview {
    LayersManager(initialView: CookieScene())
}
