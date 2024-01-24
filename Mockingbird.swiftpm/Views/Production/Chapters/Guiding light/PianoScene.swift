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
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(1), heavenSlider: .constant(0))
            
            HStack{
                ForEach(0..<7) { _ in
                    pianoKey(countTotalNotesEmited: $countTotalNotesEmited)
                }
            }
        }
        .onChange(of: countTotalNotesEmited){
            if countTotalNotesEmited==5{
                notificationManager.callNotification(ID: 0)
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
                Note()
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

struct Note: View {
    @State var noteOffset: CGFloat = -150
    @State var noteOpacity: CGFloat = 1
    
    var body: some View {
        Image("SF_note")
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
