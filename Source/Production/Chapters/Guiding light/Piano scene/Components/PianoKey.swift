//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 13/02/24.
//

import SwiftUI

struct pianoKey: View {
    
    // Amount of notes that should be spawned
    @State var amountOfNotes: Int = 0
    
    // Count how many notes have been emitted
    @Binding var countTotalNotesEmitted: Int
    
    // Index of they key
    var selectedIndex: Int = 0
    
    // Array of images for white notes
    let whiteKeys: [String] = ["piano_white_1","piano_white_2","piano_white_3"]
    
    // Array of sound effects for each note
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
                    // Play sound effect
                    playSound(name: pianoSounds[selectedIndex], ext: "mp3")
                    
                    countTotalNotesEmitted+=1
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
