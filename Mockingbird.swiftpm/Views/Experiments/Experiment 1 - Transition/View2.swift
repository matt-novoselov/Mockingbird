//
//  View2.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct View2: View {
    @State private var isNextViewVisible: Bool = false
    
    var body: some View {
        ZStack {
            View2_content(isNextViewVisible: $isNextViewVisible)
            .offset(y: isNextViewVisible ? -UIScreen.main.bounds.height : 0)
            
            if (isNextViewVisible){
                View3()
                    .offset(y: isNextViewVisible ? 0 : UIScreen.main.bounds.height)
            }
        }
        .transition(.slideTransition)
    }
}

struct View2_content: View {
    @Binding var isNextViewVisible: Bool
    
    var body: some View {
        
        ZStack{
            Color(.blue)
                .ignoresSafeArea()
            
            Exp8_timer_action()
            
            Button("Show Next View") {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isNextViewVisible.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }

    }
}
