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
        .onChange(of: countTotalNotesEmited){ _ in
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

#Preview {
    LayersManager(initialView: PianoScene())
}
