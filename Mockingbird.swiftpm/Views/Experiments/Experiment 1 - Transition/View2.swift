//
//  View2.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI


struct View2: View {
    @Binding var isNextViewVisible: Bool
    
    var body: some View {
        
        ZStack{
            Color(.blue)
                .ignoresSafeArea()
            
            Button("Show Next View") {
                withAnimation(.easeInOut(duration: 2)) {
                    isNextViewVisible.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }

    }
}
