//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI


struct Exp12_left_up_corner: View {
    let finalText: String = "For example, alcohol stimulates the release of dopamine in your body, tricking your brain into feeling pleasure."
    
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
                withAnimation(Animation.easeInOut(duration: NewTextBlob().animationMoveInDuration)) {
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
