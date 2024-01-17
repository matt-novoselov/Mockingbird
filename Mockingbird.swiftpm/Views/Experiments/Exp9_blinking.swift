//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct Exp9_blinking: View {
    @State private var rectangleVisible = false
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(rectangleVisible ? .yellow : .gray)
                .glow(color: .yellow.opacity(rectangleVisible ? 0.4 : 0.0), radius: 70)
                .onAppear {
                    blink()
                }
        }
    }
    
    private func blink() {
        var animationIntervals: [Double] = [
            2,
            0.05, 0.05, 0.05, 0.05,  // Initial quick flickers
            0.1, 0.1, 0.1,   // Initial quick flickers
            0.2, 0.2,        // Shorter pauses
            0.3, 0.3,        // Slightly longer pauses
            0.5,             // A bit longer pause
        ]

        var timePassed: Double = 0

        for interval in animationIntervals {
            timePassed += interval
            DispatchQueue.main.asyncAfter(deadline: .now() + timePassed) {
                withAnimation(.none) {
                    self.rectangleVisible.toggle()
                }
            }
        }
    }
}


#Preview {
    Exp9_blinking()
}
