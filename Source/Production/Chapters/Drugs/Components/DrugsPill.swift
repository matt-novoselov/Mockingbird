//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 24/01/24.
//

import SwiftUI

struct DrugsPill: View {
    
    var goToHeaven: (Double, Double) -> Void
    
    // Value that controls if the pill is being shown
    @Binding var showPill: Bool
    
    // Count an amount of visits to heaven
    @Binding var count: Int
    
    // Select random initial rotation effect
    @State private var rotationAngle: Double = Double.random(in: -90...90)
    
    // Adjust values for each "going to heaven" animations
    // For example first of all, the heaven background will go to 0.25, at the same time at the peak of the animation, the value of the dark background will be changed to a new one
    let heavenValues: [(Double, Double)] = [
        // Heaven value, Dark value
        (1.0, 0.75),
        (1.0, 1.0),
        (0.25, 1.0),
    ]
    
    var body: some View {
        GeometryReader{ geometry in
            Button(action: {
                let tuple = heavenValues[count - 1]
                goToHeaven(tuple.0, tuple.1)
                
                if let circlePosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                    ParticleView.spawnParticle(xpos: circlePosition.x, ypos: circlePosition.y)
                }
                
                // Play sound effect
                playSound(name: "Take_Pill", ext: "mp3")
                
                showPill = false
            }){
                Image("round_pill")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(rotationAngle))
                    .glow(color: Color("MainYellow").opacity(0.4), radius: 30)
                
                    // Play little rotation animation
                    .onAppear(){
                        withAnimation{
                            rotationAngle = 0
                        }
                    }
            }
            .buttonStyle(NoOpacityButtonStyle())
        }
        .frame(width: 60, height: 60)
        .transition(
            .asymmetric(insertion: .move(edge: .top), removal: .opacity)
        )
    }
}
