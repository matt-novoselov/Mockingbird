//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI


struct Exp12_left_up_corner: View {
    let finalText: String = "Sint commodo laborum magna fugiat culpa amet minim cillum fugiat. Reprehenderit quis sit excepteur nisi labore quis aute."
    
    @State var isTextDisplayed: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                if(isTextDisplayed){
                    NewTextBlob(finalText: finalText)
                }
                
                Spacer()
            }
            
            Spacer()
            
            Button("Button") {
                withAnimation(Animation.easeInOut) {
                    isTextDisplayed.toggle()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Exp12_left_up_corner()
}
