//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct HeavenBackground: View {
    
    // Value of the heaven slider
    @Binding var heavenSlider: Double
    
    // Value of the dark slider
    @Binding var darkSlider: Double
    
    // Point after each the transition to the new style happens
    var breakPoint: Double = 0.5
    
    // Adjust value based on the break point
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
        
            if darkSlider>0.65{
                Image("dark_dots")
                    .resizable()
                    .scaledToFill()
                    .opacity(dotsAdjustedValue / 1.5)
            }
        }
    }
}
