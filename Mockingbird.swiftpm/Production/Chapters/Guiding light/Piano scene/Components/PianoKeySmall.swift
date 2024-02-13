//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 13/02/24.
//

import SwiftUI

struct pianoKeySmall: View {
    @State var animationHasEnded: Bool = true
    @State var amountOfNotes: Int = 0
    @Binding var countTotalNotesEmited: Int
    
    var selectedIndex: Int = 0
    let blackKeys: [String] = ["piano_black_1","piano_black_2","piano_black_3"]
    let pianoSounds: [String] = [
        "piano_black_0",
        "piano_black_1",
        "piano_black_2",
        "piano_black_3",
        "piano_black_4",
        "piano_black_4",
        ]
    
    var body: some View {
        ZStack{
            ForEach(0..<amountOfNotes, id: \.self) { index in
                Note(imageName: "SF_note_2")
                    .offset(y: 100)
            }
            
            Button(
                action: {
                    playSound(name: pianoSounds[selectedIndex], ext: "mp3")
                    
                    countTotalNotesEmited+=1
                    amountOfNotes+=1
                }
            ) {
                Image(blackKeys[selectedIndex%3])
                    .interpolation(.high)
                    .resizable()
                    .frame(width: 80, height: 200)
                    .foregroundColor(.black)
            }
            .buttonStyle(NoOpacityButtonStyle())
        }
        .padding(.horizontal, 8)
    }
}
