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
    
    @State private var isGlowing = false
    @State var isAnimInProgress: Bool = true
    
    @State var displayingHint: Bool = false
    
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
                    
                    if isAnimInProgress{
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
            
            TapToContinueHint(displayingHint: $displayingHint, darkMode: true)
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                        withAnimation(.easeInOut(duration: 1.0)){
                            displayingHint = true
                        }
                    }
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                blink()
            }
        }
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
    
    func performTransition(){
        withAnimation(.easeInOut(duration: 1.0)){
            displayingHint = false
        }
        
        isAnimInProgress = false
        transitionManagerObservable.transitionToScene?(11)
    }
    
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
            isAnimInProgress = false
        }
    }
}


#Preview {
    LayersManager(initialView: LightBlinking())
}
