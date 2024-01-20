//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp17_layer_mixing: View {
    @State var darkSlider: Double = 1
    @State var heavenSlider: Double = 0
    
    var body: some View {
        VStack{
            Slider(value: $darkSlider)
                .padding()
            
            Slider(value: $heavenSlider)
                .padding()
            
            ZStack{
                WhiteBackground()
                
                DarkBackground(darkSlider: $darkSlider)
                
                HeavenBackground(heavenSlider: $heavenSlider)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    Exp17_layer_mixing()
}
