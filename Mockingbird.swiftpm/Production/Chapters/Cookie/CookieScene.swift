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
    
    @State var geomtryHolder: CGSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            VStack{
                HStack{
                    Cookie(selectedStyle: 1, countBites: $countBites, heavenSlider: $heavenSlider)
                        .background(
                            GeometryReader{ geometry in
                                Color.clear
                                    .onAppear(){
                                        geomtryHolder = geometry.size
                                    }
                            }
                        )
                    
                    Cookie(selectedStyle: 2, countBites: $countBites, heavenSlider: $heavenSlider)
                }
                
                Cookie(selectedStyle: 3, countBites: $countBites, heavenSlider: $heavenSlider)
                    .frame(maxHeight: geomtryHolder.height)
                
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
