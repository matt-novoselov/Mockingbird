//
//  File.swift
//  
//
//  Created by Matt Novoselov on 04/02/24.
//

import SwiftUI

struct Cookie: View {
    let cookiesArray: [[String]] = [
        ["cookie_1", "cookie_1_bitten"],
        ["cookie_2", "cookie_2_bitten"],
        ["cookie_3", "cookie_3_bitten"],
    ]
    
    var selectedStyle: Int = 0
    
    @State var currentDisplayedImage: String?
    @Binding var countBites: Int
    @Binding var heavenSlider: Double
    @State var isBitten: Bool = false
    
    @State var scaleCookie: Double = 1
    
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        Image(currentDisplayedImage ?? "")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture(coordinateSpace: .global) { location in
                performAction(location: location)
            }
            .scaleEffect(scaleCookie)
        .onAppear(){
            currentDisplayedImage = cookiesArray[selectedStyle][0]
        }
    }
    
    func performAction(location: CGPoint){
        if !notificationManager.isTextPrintFinished{
            return
        }
        
        if isBitten{
            return
        }
        
        isBitten = true
        
        notificationManager.closeNotification()
        
        ParticleView.spawnParticle(xpos: location.x, ypos: location.y)
        
        withAnimation(.none) {
            currentDisplayedImage = cookiesArray[selectedStyle][1]
        }
        
        withAnimation(.easeInOut(duration: 0.25)){
            scaleCookie = 0.95
        } completion: {
            withAnimation(.easeInOut(duration: 0.25)){
                scaleCookie = 1
            }
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
        
    }
}
