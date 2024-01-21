//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 20/01/24.
//

import SwiftUI

struct LayerMixingManager: View {
    @Binding var darkSlider: Double
    @Binding var heavenSlider: Double
    
    var body: some View {
        ZStack{
            WhiteBackground()
            
            DarkBackground(darkSlider: $darkSlider)
            
            HeavenBackground(heavenSlider: $heavenSlider, darkSlider: $darkSlider)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
}