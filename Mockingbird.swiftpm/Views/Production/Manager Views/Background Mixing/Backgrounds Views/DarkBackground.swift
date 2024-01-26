//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct DarkBackground: View {
    @Binding var darkSlider: Double
    
    var breakPoint: Double = 0.5
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
                .interpolation(.high)
                .resizable()
                .scaledToFill()
                .opacity(darkSlider)
            
            Image("dark_dots")
                .interpolation(.high)
                .resizable()
                .scaledToFill()
                .opacity(dotsAdjustedValue)
        }
        .ignoresSafeArea()
    }
}
