//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct EachYearStatistics: View {
    
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    // Property that controls if hint should be shown
    @State var displayingHint: Bool = false
    
    // Property to prevent accidential switch to the next scene
    @State var canTransition: Bool = false
    
    // Property that controls transition between scenes, after the transition has started
    @State var TransitionStarted: Bool = false
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            FontText(text: "Each year, over 10 million people die from various forms of addictions.", size: 64)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 150)
            
            // Hint that appears after a while to help users havigate to the next scene
            TapToContinueHint(displayingHint: $displayingHint)
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
        
        // Prevent accidential transitions to the next scene
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
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
        transitionManagerObservable.transitionToScene?(3)
    }
}

#Preview {
    LayersManager(initialView: EachYearStatistics())
}
