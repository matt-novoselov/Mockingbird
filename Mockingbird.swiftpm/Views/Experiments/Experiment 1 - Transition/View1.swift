//
//  View1.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI


struct View1: View {
    @State private var isNextViewVisible: Bool = false
    
    var body: some View {
        ZStack {
            View1_content(isNextViewVisible: $isNextViewVisible)
            .offset(y: isNextViewVisible ? -UIScreen.main.bounds.height : 0)
            
            if (isNextViewVisible){
                View2()
                    .offset(y: isNextViewVisible ? 0 : UIScreen.main.bounds.height)
            }
        }
        .transition(.slideTransition)
        .ignoresSafeArea()
    }
}

struct View1_content: View {
    @Binding var isNextViewVisible: Bool
    
    var body: some View {
        
        ZStack{
            Color(.green)
                .ignoresSafeArea()
            
            Button("Show Next View") {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isNextViewVisible.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }

    }
}
