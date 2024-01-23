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
        ZStack{
            LayerMixingManager(darkSlider: .constant(1), heavenSlider: .constant(0))
            
            HStack{
                ForEach(0..<7) { _ in
                    pianoKey()
                }
            }
        }
    }
}

struct pianoKey: View {
    @State var noteOffset: CGFloat = -150
    @State var noteOpacity: CGFloat = 1
    @State var animationHasEnded: Bool = true
    
    var body: some View {
        ZStack{
            Image("SF_note")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 65)
                .glow(color: Color("MB_main_yellow").opacity(0.6), radius: 30)
                .offset(y: noteOffset)
                .opacity(noteOpacity)
            
            Button(
                action: {
                    playSound(name: "pop", ext: "mp3")
                    
                    if !animationHasEnded{
                        return
                    }
                    animationHasEnded = false

                    withAnimation(Animation.easeOut(duration: 3)){
                        noteOffset = -400
                        noteOpacity = 0
                    } completion: {
                        withAnimation(nil){
                            noteOffset = -150
                            noteOpacity = 1
                            animationHasEnded = true
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

#Preview {
    PianoScene(transitionToScene: TransitionManager().transitionToScene)
}
