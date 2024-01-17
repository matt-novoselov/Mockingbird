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
                    View1(isNextViewVisible: $isNextViewVisible)
                }
                else{
                    View2(isNextViewVisible: $isNextViewVisible)
                }
            }
            .transition(.slideTransition)
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TestHolder()
}
