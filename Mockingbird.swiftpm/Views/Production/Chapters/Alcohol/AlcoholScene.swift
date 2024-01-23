//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct AlcoholScene: View {
    var transitionToScene: (Int) -> Void
    
    @State var imgSatuation: Double = 1
    @State var imgOpacity: Double = 1
    
    var body: some View {
        VStack{
            Image("PH_grid")
                .saturation(imgSatuation)
                .opacity(imgOpacity)
            
            Button("Button") {
                withAnimation(Animation.easeInOut(duration: 2.0)) {
                    imgSatuation = 0
                    imgOpacity = 0.6
                }
            }
        }
    }
}

#Preview {
    AlcoholScene(transitionToScene: TransitionManager().transitionToScene)
}
