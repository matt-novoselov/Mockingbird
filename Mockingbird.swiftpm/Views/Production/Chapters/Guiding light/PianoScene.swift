//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 22/01/24.
//

import SwiftUI

struct PianoScene: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        ZStack(alignment: .top){
            Color(.gray)
                .ignoresSafeArea()
            
            HStack{
                ForEach(0..<7) { _ in
                    pianoKey()
                }
            }
            
            HStack{
                ForEach(0..<6) { index in
                    smallPianoKey()
                        .opacity(index == 2 ? 0 : 1)
                }
            }
        }
    }
}

struct pianoKey: View {
    @State var noteOffset: CGFloat = -150
    @State var noteOpacity: CGFloat = 1
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
                .offset(y: noteOffset)
                .opacity(noteOpacity)
                .glow(color: .yellow, radius: 20)
            
            Button(
                action: {
                    playSound(name: "pop", ext: "mp3")
                    withAnimation(nil){
                        noteOffset = -150
                        noteOpacity = 1
                    }
                    withAnimation(Animation.easeOut(duration: 3)){
                        noteOffset = -400
                        noteOpacity = 0
                    } completion: {
                        withAnimation(nil){
                            noteOffset = -150
                            noteOpacity = 1
                        }
                    }
                }
            ) {
                Rectangle()
                    .frame(width: 100, height: 400)
                    .foregroundColor(.white)
//                    .opacity(0.5)
            }
        }
    }
}

struct smallPianoKey: View {
    @State var noteOffset: CGFloat = -150
    @State var noteOpacity: CGFloat = 1
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
                .offset(y: noteOffset)
                .opacity(noteOpacity)
                .glow(color: .yellow, radius: 20)
            
            Button(
                action: {
                    playSound(name: "pop", ext: "mp3")
                    withAnimation(nil){
                        noteOffset = -150
                        noteOpacity = 1
                    }
                    withAnimation(Animation.easeOut(duration: 3)){
                        noteOffset = -400
                        noteOpacity = 0
                    } completion: {
                        withAnimation(nil){
                            noteOffset = -150
                            noteOpacity = 1
                        }
                    }
                }
            ) {
                Rectangle()
                    .frame(width: 100, height: 300)
                    .foregroundColor(.black)
//                    .opacity(0.5)
            }
        }
    }
}

#Preview {
    PianoScene(transitionToScene: TransitionManager().transitionToScene)
}
