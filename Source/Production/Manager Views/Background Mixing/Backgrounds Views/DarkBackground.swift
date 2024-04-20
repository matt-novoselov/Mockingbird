//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct DarkBackground: View {
    
    // Value of the dark slider
    @Binding var darkSlider: Double
    
    // Point after each the transition to the new style happens
    var breakPoint: Double = 0.5
    
    // Adjust value based on the break point
    var dotsAdjustedValue: Double {
        if darkSlider <= breakPoint {
            return darkSlider / 2
        } else {
            return (breakPoint - (darkSlider - breakPoint)) / 2
        }
    }
    
    var body: some View {
        ZStack{            
            Image("dark_background")
                .resizable()
                .scaledToFill()
                .opacity(darkSlider)
            
            Image("dark_dots")
                .resizable()
                .scaledToFill()
                .opacity(dotsAdjustedValue)
        }
    }
}
