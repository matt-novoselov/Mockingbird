//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 04/02/24.
//

import SwiftUI

struct AlcoholDrink: View {
    @State var currentDisplayedImage: String?
    
    let cookiesArray: [[String]] = [
        ["bottle_empty", "bottle_filled"],
        ["little_glass_empty", "little_glass_filled"],
        ["wine_glass_empty", "wine_glass_filled"],
    ]
    
    var selectedStyle: Int = 0
    
    @Binding var countBites: Int
    @Binding var heavenSlider: Double
    @State var isBitten: Bool = false
    
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    @State var buttonPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    @State var geomtryHolder: GeometryProxy?
    
    @Binding var currentDrinkID: Int
    
    var body: some View {
        Button(action: {
            if !notificationManager.isTextPrintFinished{
                return
            }
            
            if isBitten{
                return
            }
            
            if let geometryHolder = geomtryHolder,
               let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometryHolder) {
                ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
            }
            
            isBitten = true
            
            notificationManager.closeNotification()
            
            withAnimation() {
                currentDisplayedImage = cookiesArray[selectedStyle][0]
            }
            
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
            
            let animationDuration = 2.0
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0.5
            } completion: {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    heavenSlider = 0
                } completion: {
                    transitionToNextPost()
                }
            }
            
        })
        {
            Image(currentDisplayedImage ?? "")
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
        .onAppear(){
            currentDisplayedImage = cookiesArray[selectedStyle][1]
        }
        .padding(.top, selectedStyle == 1 ? 200 : 0)
        .padding(.top, selectedStyle == 2 ? 50 : 0)
    }
    
    func transitionToNextPost() {
        withAnimation(.easeInOut(duration: 1)) {
            if currentDrinkID<2{
                currentDrinkID += 1
            }
        }
    }
}
