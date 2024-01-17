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
            Color(.yellow)
                .ignoresSafeArea()
            
            Button("Show Next View") {
                transitionToScene(0)
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}
