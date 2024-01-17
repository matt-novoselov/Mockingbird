//
//  View2.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI


struct View2: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        ZStack{
            Color(.blue)
                .ignoresSafeArea()
            
            Button("Show Next View") {
                transitionToScene(2)
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}
