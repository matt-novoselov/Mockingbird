//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct LightBlinking: View {
    @State private var rectangleVisible = false
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack{
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(rectangleVisible ? .yellow : .gray)
                    .glow(color: .yellow.opacity(rectangleVisible ? 0.4 : 0.0), radius: 70)
                    .onAppear {
                        blink()
                    }
                
                Text("guiding light")
                    .foregroundColor(.yellow)
                    .shadow(color: .yellow, radius: 10)
                
                Text("guiding light")
                    .foregroundColor(.yellow)
                    .glow(color: .yellow.opacity(0.4), radius: 10)
                
                ZStack{
                    Group {
                        Text("Even in the darkest time you can find the the the the the the ")
                            .foregroundColor(.white) +
                        
                        Text("guiding light")
                            .foregroundColor(.yellow)
                    }
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                    Text("Even in the darkest time you can find the the the the the the guiding light")
                        .foregroundColor(.yellow)
                        .glow(color: .yellow.opacity(0.4), radius: 10)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                }
                

            }
        }
    }
    
    private func blink() {
        let animationIntervals: [Double] = [
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
    LightBlinking()
}
