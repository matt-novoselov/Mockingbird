//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 20/01/24.
//

import SwiftUI

struct Exp22_background_anim: View {
    @State var darkSlider: Double = 0
    @State var heavenSlider: Double = 0
    
    var body: some View {
        ZStack{
            LayerMixing(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            Button("Button") {
                let animationDuration = 3.0
                
                withAnimation(.easeInOut(duration: animationDuration)) {
                    heavenSlider = 0.5
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        heavenSlider = 0
                    }
                }
            }

        }
    }
}

#Preview {
    Exp22_background_anim()
}
