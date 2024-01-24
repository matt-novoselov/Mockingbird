//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 24/01/24.
//

import SwiftUI

struct DrugsPill: View {
    var goToHeaven: (Double, Double) -> Void
    @Binding var showPill: Bool
    @Binding var count: Int
    
    
    let heavenValues: [(Double, Double)] = [
        (1.0, 0.8),
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
                
                showPill = false
            }){
                Circle()
                    .foregroundColor(Color("MainYellow"))
                    .padding()
            }
            .buttonStyle(NoOpacityButtonStyle())
        }
        .frame(width: 100, height: 100)
        .transition(
            .asymmetric(insertion: .move(edge: .top), removal: .opacity)
        )
    }
}
