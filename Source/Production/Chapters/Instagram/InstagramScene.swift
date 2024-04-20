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
    
    // Value of the dark background
    @State var darkSlider: Double = 0
    
    // Value of the heaven background
    @State var heavenSlider: Double = 0
    
    // Count how many times the animation "going to heaven" was played
    @State var countVisitsToHeaven: Int = 0
    
    // Property that controls if animation "going to heaven" is currenlty being played
    @State var isInHeaven: Bool = false
    
    @State private var shouldChangePost: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            Image("iphone_frame")
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .allowsHitTesting(false)
                .opacity(0)
                .background(
                    ZStack{
                        Image("iphone_frame")
                            .interpolation(.high)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        // Main interactable part of the Scene
                        InstagramViewController(action: handleOnReaction, shouldChangePost: $shouldChangePost)
                            .environmentObject(transitionManagerObservable)
                            .mask(
                                Image("iphone_frame")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            )
                    }
                )
                .overlay(
                    ZStack{
                        Image("iphone_bezel")
                            .interpolation(.high)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .allowsHitTesting(false)
                        
                        VStack{
                            // Easter egg with dynamic island
                            Button(action: {}){
                                Image("dynamic_island")
                                    .interpolation(.high)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .buttonStyle(ScaleUpButtonStyle())
                            
                            Spacer()
                        }
                    }
                        .padding(.all, -10)
                )
                .padding(.vertical, 100)
            
        }
    }
    
    // Function that is being call after user posts a reaction
    func handleOnReaction(){
        
        if countVisitsToHeaven>2{
            return
        }
        
        // Adjust values for each "going to heaven" animations
        // For example first of all, the heaven background will go to 0.25, at the same time at the peak of the animation, the value of the dark background will be changed to a new one
        let heavenValues: [(Double, Double)] = [
            // Heaven value, Dark value
            (0.25, 0.05),
            (0.25, 0.1),
            (0.25, 0.15),
        ]
        
        let tuple = heavenValues[countVisitsToHeaven]
        goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
    }
    
    // Function that plays "going to heaven" animation
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        
        countVisitsToHeaven+=1
        isInHeaven = true
        
        // Adjust animation duration
        let animationDuration = 1.0
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = heavenSliderGoal ?? 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            withAnimation(.easeInOut(duration: 0.5)) {
                darkSlider = darkSliderAfterwards ?? darkSlider
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                withAnimation(nil){
                    // handle end of visit to heaven
                    isInHeaven = false
                    
                    if countVisitsToHeaven == 1{
                        notificationManager.callNotification(ID: 7)
                    }
                    else if countVisitsToHeaven == 2{
                        notificationManager.callNotification(ID: 8)
                    }
                    else if countVisitsToHeaven == 3{
                        notificationManager.callNotification(
                            ID: 9,
                            arrowAction: {
                                transitionManagerObservable.transitionToScene?(6)
                            }
                        )
                    }
                    
                    // transition to next post
                    withAnimation(nil){
                        shouldChangePost.toggle()
                    }
                }
            }
        }
        
    }
}

#Preview {
    LayersManager(initialView: InstagramScene())
}
