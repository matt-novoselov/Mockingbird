//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct HeavenBackground: View {
    @Binding var heavenSlider: Double
    
    var breakPoint: Double = 0.5
    var dotsAdjustedValue: Double {
        if heavenSlider <= breakPoint {
            return heavenSlider / 2
        } else {
            return (breakPoint - (heavenSlider - breakPoint)) / 2
        }
    }
    
    var body: some View {
        ZStack{
            Image("heaven_background")
                .resizable()
                .scaledToFill()
                .opacity(heavenSlider)
            
//            Image("dark_dots")
//                .resizable()
//                .scaledToFill()
//                .opacity(dotsAdjustedValue)
        }
        .ignoresSafeArea()
    }
}
