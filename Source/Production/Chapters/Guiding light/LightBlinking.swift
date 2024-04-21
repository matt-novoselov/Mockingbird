//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct LightBlinking: View {
    
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    // Property that controls if the text currently has glowing effect
    @State private var isGlowing = false
    
    // Property that controls if animation is currently being played
    @State var isAnimationInProgress: Bool = true
    
    // Property that controls if hint should be shown
    @State var displayingHint: Bool = false
    
    // Property to prevent accidental switch to the next scene
    @State var canTransition: Bool = false
    
    // Property that controls transition between scenes, after the transition has started
    @State var TransitionStarted: Bool = false
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(1), heavenSlider: .constant(0))
            
            VStack{
                FontText(text: "Even in the darkest time you", size: 96)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                HStack{
                    FontText(text: "can find the ", size: 96)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    // Glowing text
                    if isAnimationInProgress{
                        FontText(text: "guiding light", size: 96)
                            .multilineTextAlignment(.center)
                            .foregroundColor(isGlowing ? .yellow : .white)
                            .glow(color: Color("MainYellow").opacity(isGlowing ? 0.4 : 0.0), radius: 70)
                    }
                    else{
                        FontText(text: "guiding light", size: 96)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.yellow)
                            .glow(color: Color("MainYellow").opacity(0.4), radius: 70)
                    }

                }
            }
            
            // Hint that appears after a while to help users navigate to the next scene
            TapToContinueHint(displayingHint: $displayingHint, darkMode: true)
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        if !TransitionStarted{
                            withAnimation(.easeInOut(duration: 1.0)){
                                displayingHint = true
                            }
                        }
                    }
                }
        }
        
        // Delay blinking animation before transition is complete
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                blink()
                canTransition = true
            }
        }
        
        // Transition to the next scene on tap or slide
        .gesture(
            TapGesture()
                .onEnded {
                    performTransition()
                }
                .exclusively(before: DragGesture()
                    .onEnded { value in
                        if value.translation.height < 0 {
                            performTransition()
                        }
                    }
                )
        )
        
    }
    
    // Function to perform transition
    func performTransition(){
        if !canTransition{
            return
        }
        
        TransitionStarted = true
        
        withAnimation(.easeInOut(duration: 1.0)){
            displayingHint = false
        }
        
        isAnimationInProgress = false
        transitionManagerObservable.transitionToScene?(11)
    }
    
    // Function for blinking aniamtion
    private func blink() {
        let animationIntervals: [Double] = [
            0.1, 0.1, 0.1, 0.1,   // Initial quick flickers
            0.2, 0.2,        // Shorter pauses
            0.3, 0.3,        // Slightly longer pauses
            0.5,           // A bit longer pause
        ]

        var timePassed: Double = 0

        for interval in animationIntervals {
            timePassed += interval
            DispatchQueue.main.asyncAfter(deadline: .now() + timePassed) {
                withAnimation {
                    self.isGlowing.toggle()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + animationIntervals.reduce(0, +)) {
            isAnimationInProgress = false
        }
    }
}


#Preview {
    LayersManager(initialView: LightBlinking())
}
