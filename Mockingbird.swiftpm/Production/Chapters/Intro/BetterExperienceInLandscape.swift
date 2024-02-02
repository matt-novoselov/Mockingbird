//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct BetterExperienceInLandscape: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            VStack (spacing: 0){
                Image("SF_orientation")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 95)
                    .rotationEffect(Angle(degrees: 90))
                
                FontText(text: "Better experience in the landscape mode", size: 64)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal, 100)
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
    LayersManager(initialView: BetterExperienceInLandscape())
}
