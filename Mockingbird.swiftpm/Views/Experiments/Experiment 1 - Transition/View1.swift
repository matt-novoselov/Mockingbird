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
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
            
            Button("Show Next View") {
                transitionToScene(1)
            }
            .foregroundColor(.green)
            .buttonStyle(.borderedProminent)
        }
        
    }
}

#Preview {
    View1(transitionToScene: TransitionManager().transitionToScene)
}
