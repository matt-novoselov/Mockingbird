//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct BetterExperienceInHeadphones: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            VStack (spacing: 0){
                Image("SF_headphones")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                
                FontText(text: "Better experience with headphones ", size: 64)
                    .multilineTextAlignment(.center)
                    .padding()
            }

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                transitionManagerObservable.transitionToScene?(1)
            }
        }
    }
}

#Preview {
    LayersManager(initialView: BetterExperienceInHeadphones())
}
