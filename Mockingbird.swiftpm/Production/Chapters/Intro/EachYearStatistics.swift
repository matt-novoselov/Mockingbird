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
    
    @State var displayingHint: Bool = false
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            FontText(text: "Each year, over 10 million people die from various forms of addictions.", size: 64)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 150)
            
            TapToContinueHint(displayingHint: $displayingHint)
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        withAnimation(.easeInOut(duration: 0.5)){
                            displayingHint = true
                        }
                    }
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
        withAnimation(.easeInOut(duration: 0.5)){
            displayingHint = false
        }
        transitionManagerObservable.transitionToScene?(3)
    }
}

#Preview {
    LayersManager(initialView: EachYearStatistics())
}
