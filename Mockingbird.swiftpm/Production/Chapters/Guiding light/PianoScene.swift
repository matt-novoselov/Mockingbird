//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 22/01/24.
//

import SwiftUI

struct PianoScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var countTotalNotesEmited: Int = 0
    
    @State public var darkSlider: Double = 1
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: .constant(0))
            
            ZStack(alignment: .top){
                HStack{
                    ForEach(0..<7) { index in
                        pianoKey(countTotalNotesEmited: $countTotalNotesEmited, selectedIndex: index)
                    }
                }
                
                HStack{
                    ForEach(0..<6) { index in
                        pianoKeySmall(countTotalNotesEmited: $countTotalNotesEmited, selectedIndex: index)
                            .opacity(index==2 ? 0 : 1)
                    }
                }
            }
            .scaleEffect(0.7)

        }
        .onChange(of: countTotalNotesEmited){
            if countTotalNotesEmited<=3{
                withAnimation(Animation.easeInOut(duration: 5.0)){
                    darkSlider -= 0.07
                }
            }

            if countTotalNotesEmited==3{
                notificationManager.callNotification(ID: 16, arrowAction: {
                    transitionManagerObservable.transitionToScene?(12)
                }, darkMode: true)
            }
        }
    }
}

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

#Preview {
    LayersManager(initialView: PianoScene())
}
