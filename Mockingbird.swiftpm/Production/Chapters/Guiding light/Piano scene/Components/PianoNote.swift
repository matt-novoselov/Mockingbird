//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 13/02/24.
//

import SwiftUI

struct Note: View {
    @State var noteOffset: CGFloat = -150
    @State var noteOpacity: CGFloat = 1
    var imageName: String = ""
    
    var body: some View {
        Image(imageName)
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 65)
            .glow(color: Color("MainYellow").opacity(0.6), radius: 30)
            .offset(y: noteOffset)
            .opacity(noteOpacity)
            .onAppear(){
                withAnimation(Animation.easeOut(duration: 3)){
                    noteOffset = -400
                    noteOpacity = 0
                }
            }
    }
}
