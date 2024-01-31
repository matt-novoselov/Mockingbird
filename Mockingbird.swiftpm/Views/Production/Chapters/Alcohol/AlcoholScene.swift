//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct AlcoholScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
//    @State var imgSatuation: Double = 1
//    @State var imgOpacity: Double = 1
    
    @State var countBites: Int = 0
    @State var heavenSlider: Double = 0
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            HStack{
                AlcoholDrink(countBites: $countBites, heavenSlider: $heavenSlider)
                    .environmentObject(notificationManager)
                    .environmentObject(transitionManagerObservable)
                
                AlcoholDrink(countBites: $countBites, heavenSlider: $heavenSlider)
                    .environmentObject(notificationManager)
                    .environmentObject(transitionManagerObservable)
                
                AlcoholDrink(countBites: $countBites, heavenSlider: $heavenSlider)
                    .environmentObject(notificationManager)
                    .environmentObject(transitionManagerObservable)
            }
            .padding()
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                    notificationManager.callNotification(ID: 3)
                }
            }
            
//            VStack{
//                Image("PH_grid")
//                    .interpolation(.high)
//                    .saturation(imgSatuation)
//                    .opacity(imgOpacity)
//                
//                Button("Button") {
//                    withAnimation(Animation.easeInOut(duration: 2.0)) {
//                        imgSatuation = 0
//                        imgOpacity = 0.8
//                    }
//                    
//                    notificationManager.callNotification(ID: 6, arrowAction: {
//                        transitionManagerObservable.transitionToScene?(5)
//                    })
//                }
//            }
        }
    }
}

struct AlcoholDrink: View {
    @State var currentDisplayedImage: String = "PH_grid"
    @Binding var countBites: Int
    @Binding var heavenSlider: Double
    @State var isBitten: Bool = false
    
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    @State var buttonPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    var body: some View {
        Button(action: {
            if !notificationManager.isTextPrintFinished{
                return
            }
            
            if isBitten{
                return
            }
            
            ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
            
            
            isBitten = true
            
            notificationManager.closeNotification()
            
            withAnimation(.none) {
                currentDisplayedImage = "PH_calendar"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + NotificationTextBlob().animationMoveInDuration + 0.1) {
                
                if countBites != 2{
                    notificationManager.callNotification(
                        ID: countBites + 4
                    )
                }
                else{
                    notificationManager.callNotification(
                        ID: countBites + 4,
                        arrowAction: {
                            transitionManagerObservable.transitionToScene?(5)
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
                .background(
                    GeometryReader{ geometry in
                        Color.clear
                            .onAppear(){
                                if let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                                    self.buttonPosition = buttonPosition
                                }
                            }
                    }
                )
        }
        .buttonStyle(NoOpacityButtonStyle())
    }
}

#Preview {
    LayersManager(initialView: AlcoholScene())
}
