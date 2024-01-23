//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 20/01/24.
//

import SwiftUI

struct DemoBackgroundAnimation: View {
    @State var darkSlider: Double = 0
    @State var heavenSlider: Double = 0
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            Button("Button") {
                let animationDuration = 3.0
                
                withAnimation(.easeInOut(duration: animationDuration)) {
                    heavenSlider = 0.5
                } completion: {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        heavenSlider = 0
                    }
                }
            }

        }
    }
}

#Preview {
    DemoBackgroundAnimation()
}
