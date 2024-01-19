//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct HeavenBackground: View {
    @Binding var heavenSlider: Double
    
    var body: some View {
        ZStack{
            Image("heaven")
                .resizable()
                .scaledToFill()
                .opacity(heavenSlider)
        }
        .ignoresSafeArea()
    }
}
