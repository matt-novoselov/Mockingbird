//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 13/02/24.
//

import SwiftUI

struct pianoKey: View {
    @State var animationHasEnded: Bool = true
    @State var amountOfNotes: Int = 0
    @Binding var countTotalNotesEmited: Int
    
    var selectedIndex: Int = 0
    
    let whiteKeys: [String] = ["piano_white_1","piano_white_2","piano_white_3"]
    let pianoSounds: [String] = [
        "piano_white_0",
        "piano_white_1",
        "piano_white_2",
        "piano_white_3",
        "piano_white_4",
        "piano_white_5",
        "piano_white_6"
    ]
    
    var body: some View {
        ZStack{
            ForEach(0..<amountOfNotes, id: \.self) { index in
                Note(imageName: "SF_note")
            }
            
            Button(
                action: {
                    playSound(name: pianoSounds[selectedIndex], ext: "mp3")
                    
                    countTotalNotesEmited+=1
                    amountOfNotes+=1
                }
            ) {
                Image(whiteKeys[selectedIndex%3])
                    .interpolation(.high)
                    .resizable()
                    .frame(width: 100, height: 400)
                    .foregroundColor(.white)
            }
            .buttonStyle(NoOpacityButtonStyle())
        }
    }
}
