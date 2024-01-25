//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct AlcoholScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var imgSatuation: Double = 1
    @State var imgOpacity: Double = 1
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            VStack{
                Image("PH_grid")
                    .saturation(imgSatuation)
                    .opacity(imgOpacity)
                
                Button("Button") {
                    withAnimation(Animation.easeInOut(duration: 2.0)) {
                        imgSatuation = 0
                        imgOpacity = 0.8
                    }
                    
                    notificationManager.callNotification(ID: 6, arrowAction: {
                        transitionManagerObservable.transitionToScene?(5)
                    })
                }
            }
        }
    }
}

#Preview {
    LayersManager(initialView: AlcoholScene())
}
