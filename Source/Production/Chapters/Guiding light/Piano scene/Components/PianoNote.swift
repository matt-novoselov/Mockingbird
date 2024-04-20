//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 13/02/24.
//

import SwiftUI

struct Note: View {
    
    // Initial offset of the note
    @State var noteOffset: CGFloat = -150
    
    // Initial opacity of the note
    @State var noteOpacity: CGFloat = 1
    
    // Name of the image for the note
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 65)
            .glow(color: Color("MainYellow").opacity(0.6), radius: 30)
            .offset(y: noteOffset)
            .opacity(noteOpacity)
        
            // Start animation on appear
            .onAppear(){
                withAnimation(Animation.easeOut(duration: 3)){
                    noteOffset = -400
                    noteOpacity = 0
                }
            }
        
    }
}
