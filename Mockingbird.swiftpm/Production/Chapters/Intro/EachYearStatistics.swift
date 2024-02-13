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
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            FontText(text: "Each year, over 10 million people die from various forms of addictions.", size: 64)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 150)
        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//                transitionManagerObservable.transitionToScene?(3)
//            }
//        }
        
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
        transitionManagerObservable.transitionToScene?(3)
    }
}

#Preview {
    LayersManager(initialView: EachYearStatistics())
}
