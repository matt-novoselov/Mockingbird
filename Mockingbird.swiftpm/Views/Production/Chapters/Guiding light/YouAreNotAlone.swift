//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct YouAreNotAlone: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(1), heavenSlider: .constant(0))
            
            Text("You are not alone")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    LayersManager(initialView: YouAreNotAlone())
}
