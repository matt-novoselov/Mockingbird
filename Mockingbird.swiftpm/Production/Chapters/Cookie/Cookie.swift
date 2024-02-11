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
    
    @Binding var countBites: Int
    @Binding var heavenSlider: Double
    @State var isBitten: Bool = false
    
    @State var scaleCookie: Double = 1
    
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        Image(isBitten ? "cookie_\(selectedStyle+1)_bitten" : "cookie_\(selectedStyle+1)")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture(coordinateSpace: .global) { location in
                performAction(location: location)
            }
            .scaleEffect(scaleCookie)
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
        
        withAnimation(.easeInOut(duration: 0.25)){
            scaleCookie = 0.95
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
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
        
        let animationDuration = 2.0
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = 0.25
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            }
        }
        
    }
}
