//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct View3: View {
    @State private var isNextViewVisible: Bool = false
    
    var body: some View {
        ZStack {
            View3_content(isNextViewVisible: $isNextViewVisible)
            .offset(y: isNextViewVisible ? -UIScreen.main.bounds.height : 0)
            
            if (isNextViewVisible){
                View1()
                    .offset(y: isNextViewVisible ? 0 : UIScreen.main.bounds.height)
            }
        }
        .transition(.slideTransition)
        .ignoresSafeArea()
    }
}

struct View3_content: View {
    @Binding var isNextViewVisible: Bool
    
    var body: some View {
        
        ZStack{
            Color(.yellow)
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
