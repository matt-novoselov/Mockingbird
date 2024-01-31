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
                    ForEach(0..<7) { _ in
                        pianoKey(countTotalNotesEmited: $countTotalNotesEmited)
                    }
                }
                
                HStack{
                    ForEach(0..<6) { index in
                        pianoKeySmall(countTotalNotesEmited: $countTotalNotesEmited)
                            .opacity(index==2 ? 0 : 1)
                    }
                }
            }
            .scaleEffect(0.7)

        }
        .onChange(of: countTotalNotesEmited){
            if countTotalNotesEmited == 2{
                withAnimation(Animation.easeInOut(duration: 5.0)){
                    darkSlider = 0.8
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
    
    var body: some View {
        ZStack{
            ForEach(0..<amountOfNotes, id: \.self) { index in
                Note(imageName: "SF_note")
            }
            
            Button(
                action: {
                    playSound(name: "pop", ext: "mp3")
                    
                    countTotalNotesEmited+=1
                    amountOfNotes+=1
                }
            ) {
                Rectangle()
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
    
    var body: some View {
        ZStack{
            ForEach(0..<amountOfNotes, id: \.self) { index in
                Note(imageName: "SF_note_2")
                    .offset(y: 100)
            }
            
            Button(
                action: {
                    playSound(name: "pop", ext: "mp3")
                    
                    countTotalNotesEmited+=1
                    amountOfNotes+=1
                }
            ) {
                Rectangle()
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
