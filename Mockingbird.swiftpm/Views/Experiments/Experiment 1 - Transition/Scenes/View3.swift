//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI


struct View3: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        ZStack{
            GeometryReader { _ in
                LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(1))
            }
            
            VStack{
                Spacer()
                
                Button("Show Next View") {
                    transitionToScene(0)
                }
                .foregroundColor(.yellow)
                .buttonStyle(.borderedProminent)
            }
        }
        
    }
}
