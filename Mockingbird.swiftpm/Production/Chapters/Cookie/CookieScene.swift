//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct CookieScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var heavenSlider: Double = 0
    @State var countBites: Int = 0
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            VStack{
                HStack{
                    Cookie(selectedStyle: 0, countBites: $countBites, heavenSlider: $heavenSlider)
                    
                    Cookie(selectedStyle: 1, countBites: $countBites, heavenSlider: $heavenSlider)
                }
                
                Cookie(selectedStyle: 2, countBites: $countBites, heavenSlider: $heavenSlider)
            }
            .environmentObject(notificationManager)
            .environmentObject(transitionManagerObservable)
            .padding(.all, 100)
            
        }
    }
}

#Preview {
    LayersManager(initialView: CookieScene())
}
