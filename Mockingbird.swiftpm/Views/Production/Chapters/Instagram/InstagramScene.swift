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
    
    @State var darkSlider: Double = 0
    @State var heavenSlider: Double = 0
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            InstagramViewController()
                .padding(.all, 100)
                .environmentObject(transitionManagerObservable)
        }
    }
}

#Preview {
    LayersManager(initialView: InstagramScene())
}
