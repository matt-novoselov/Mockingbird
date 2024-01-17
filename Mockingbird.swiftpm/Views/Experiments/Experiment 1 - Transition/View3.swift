//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI


struct View3: View {
    @Binding var isNextViewVisible: Bool
    
    var body: some View {
        
        ZStack{
            Color(.yellow)
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
