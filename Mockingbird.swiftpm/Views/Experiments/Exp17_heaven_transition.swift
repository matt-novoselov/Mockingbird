//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp17_heaven_transition: View {
    @State var heavenSlider: Double = 0
    @State var darkSlider: Double = 0
    
    var body: some View {
        VStack{
            Slider(value: $heavenSlider)
                .padding()
            
            Slider(value: $darkSlider)
                .padding()
            
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                
                Image("dark")
                    .resizable()
                    .scaledToFill()
                    .opacity(darkSlider)
                
                Image("heaven")
                    .resizable()
                    .scaledToFill()
                    .opacity(heavenSlider)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    Exp17_heaven_transition()
}
