//
//  View1.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI


struct View1: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            HStack{
                Spacer()
                
                Button("Show Next View") {
                    transitionToScene(1)
                }
                .foregroundColor(.yellow)
                .buttonStyle(.borderedProminent)
            }
        }
        
    }
}

#Preview {
    View1(transitionToScene: TransitionManager().transitionToScene)
}
