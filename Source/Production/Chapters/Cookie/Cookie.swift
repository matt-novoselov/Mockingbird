//
//  File.swift
//  
//
//  Created by Matt Novoselov on 04/02/24.
//

import SwiftUI

struct Cookie: View {
    
    // Control the style (texture variant) of the cookie
    var selectedStyle: Int = 0
    
    // Count total amount of times the cookie was bitten
    @Binding var countBites: Int
    
    // Control the value of heaven background
    @Binding var heavenSlider: Double
    
    // Size of the cookie for on click animation
    @State var scaleCookie: Double = 1
    
    // Count amount of times the current cookie was bitten
    @State var countLocalBites: Int = 0
    
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        Image("cookie_\(selectedStyle)_stage_\(countLocalBites)")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture(coordinateSpace: .global) { location in
                performAction(location: location)
            }
            .scaleEffect(scaleCookie)
    }
    
    // Action that happens after the cookie was bitten
    func performAction(location: CGPoint){
        if countBites>=3{
            return
        }
        
        if !notificationManager.isTextPrintFinished{
            return
        }
        
        // Play particles animation
        ParticleView.spawnParticle(xpos: location.x, ypos: location.y)
        
        // Play sound effect
        playSound(name: "Cookie_\(countBites+1)", ext: "mp3")
        
        // Create scale up animation
        withAnimation(.easeInOut(duration: 0.25)){
            scaleCookie = 0.95
        }
        
        // Create scale down animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
            withAnimation(.easeInOut(duration: 0.25)){
                scaleCookie = 1
            }
        }
        
        // Call according notification
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
        
        countLocalBites+=1
        countBites+=1
        
        // Adjust heaven animation duration
        let animationDuration = 2.0
        
        // Play heaven animation
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
