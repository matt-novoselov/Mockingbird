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
    
    @State var screenSize: CGSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                Color.red.opacity(0)
                    .onAppear {
                        print(geometry.size)
                        screenSize = geometry.size
                    }
            }
            
            ZStack{
                WhiteBackground()
                
                DarkBackground(darkSlider: $darkSlider)
                
                HeavenBackground(heavenSlider: $heavenSlider, darkSlider: $darkSlider)
            }
            .frame(width: screenSize.width, height: screenSize.height)
        }
    }
}

#Preview {
    LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
}
