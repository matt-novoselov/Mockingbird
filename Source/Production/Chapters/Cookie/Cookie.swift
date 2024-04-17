//
//  File.swift
//  
//
//  Created by Matt Novoselov on 04/02/24.
//

import SwiftUI

struct Cookie: View {    
    var selectedStyle: Int = 0
    
    @Binding var countBites: Int
    @Binding var heavenSlider: Double
    
    @State var scaleCookie: Double = 1
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
    
    func performAction(location: CGPoint){
        if countBites>=3{
            return
        }
        
        if !notificationManager.isTextPrintFinished{
            return
        }
        
        ParticleView.spawnParticle(xpos: location.x, ypos: location.y)
        
        playSound(name: "Cookie_\(countBites+1)", ext: "mp3")
        
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
        
        countLocalBites+=1
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
