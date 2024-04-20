//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 20/01/24.
//

import SwiftUI

// View that is responsible for combining different background layers
struct LayerMixingManager: View {
    
    @Binding var darkSlider: Double
    @Binding var heavenSlider: Double
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                
                WhiteBackground()
                
                DarkBackground(darkSlider: $darkSlider)
                
                HeavenBackground(heavenSlider: $heavenSlider, darkSlider: $darkSlider)
                
            }
        }
    }
}

#Preview {
    LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
}
