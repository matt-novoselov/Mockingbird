//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct TestHolder: View {
    @State private var isNextViewVisible: Bool = false
    
    var body: some View {
        VStack{
            Group{
                if (isNextViewVisible){
                    View1(toggleView: toggleView)
                }
                else{
                    View2(toggleView: toggleView)
                }
            }
            .transition(.slideTransition)
            
        }
        .ignoresSafeArea()
    }
    
    func toggleView() {
        withAnimation(.easeInOut(duration: 2)) {
            isNextViewVisible.toggle()
        }
    }
}

#Preview {
    TestHolder()
}
