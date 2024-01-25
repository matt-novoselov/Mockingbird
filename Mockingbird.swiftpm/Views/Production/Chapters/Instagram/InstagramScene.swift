//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct InstagramScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var darkSlider: Double = 0
    @State var heavenSlider: Double = 0
    
    @State var countVisitsToHeaven: Int = 0
    @State var isInHeaven: Bool = false
    
    @State private var shouldChangePost: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            InstagramViewController(action: handleOnReaction, shouldChangePost: $shouldChangePost)
                .padding(.all, 100)
                .environmentObject(transitionManagerObservable)
        }
    }
    
    func handleOnReaction(){
        let heavenValues: [(Double, Double)] = [
            (0.25, 0.05),
            (0.25, 0.1),
            (0.25, 0.15),
        ]
        
        if countVisitsToHeaven<3{
            let tuple = heavenValues[countVisitsToHeaven]
            goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
        }
        else{
            notificationManager.callNotification(
                ID: 9,
                arrowAction: {
                    transitionManagerObservable.transitionToScene?(6)
                }
            )
        }
    }
    
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        notificationManager.closeNotification()
        
        countVisitsToHeaven+=1
        isInHeaven = true
        let animationDuration = 2.0
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = heavenSliderGoal ?? 1.0
        } completion: {
            withAnimation(.easeInOut(duration: 0.5)) {
                darkSlider = darkSliderAfterwards ?? darkSlider
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            } completion: {
                // handle end of visit to heaven
                
                isInHeaven = false
                
                // transition to next post
                // P.S. this is a very weird way of calling a function
                shouldChangePost.toggle()
                
                if countVisitsToHeaven == 1{
                    notificationManager.callNotification(ID: 7)
                }
                else if countVisitsToHeaven == 2{
                    notificationManager.callNotification(ID: 8)
                }
            }
        }
    }
}

#Preview {
    LayersManager(initialView: InstagramScene())
}
