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
    
    // Count an amount of notes that have been played
    @State var countTotalNotesEmitted: Int = 0
    
    // Property that controls value of the dark slider
    @State public var darkSlider: Double = 1
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: .constant(0))
            
            ZStack(alignment: .top){
                // Spawn white piano keys
                HStack{
                    ForEach(0..<7) { index in
                        pianoKey(countTotalNotesEmitted: $countTotalNotesEmitted, selectedIndex: index)
                    }
                }
                
                // Spawn small black piano keys
                HStack{
                    ForEach(0..<6) { index in
                        pianoKeySmall(countTotalNotesEmitted: $countTotalNotesEmitted, selectedIndex: index)
                            .opacity(index==2 ? 0 : 1)
                    }
                }
            }
            .scaleEffect(0.7)

        }
        
        // Action that happens after user emits new note
        .onChange(of: countTotalNotesEmitted){
            
            // Update value of dark slider with each emitted note
            if countTotalNotesEmitted<=3{
                withAnimation(Animation.easeInOut(duration: 5.0)){
                    darkSlider -= 0.07
                }
            }
            
            // Call notification on 3rd emitted note
            if countTotalNotesEmitted==3{
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
