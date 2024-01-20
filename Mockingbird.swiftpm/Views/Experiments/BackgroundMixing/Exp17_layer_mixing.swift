//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp17_layer_mixing: View {
    @State var darkSlider: Double = 0
    @State var heavenSlider: Double = 0
    
    var body: some View {
        VStack{
            Text(darkSlider.description)
            
            Slider(value: $darkSlider)
                .tint(.black)
                .padding()
            
            Text(heavenSlider.description)
            
            Slider(value: $heavenSlider)
                .tint(.yellow)
                .padding()
            
            LayerMixing(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
        }
    }
}

#Preview {
    Exp17_layer_mixing()
}
