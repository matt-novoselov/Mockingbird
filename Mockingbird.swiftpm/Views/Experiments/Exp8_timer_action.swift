//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct Exp8_timer_action: View {
    @State private var rectangleVisible = false

    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(rectangleVisible ? .blue : .green)
        }
        .onAppear {
            // Use Timer to delay the appearance of the rectangle
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                // Update the state variable to make the rectangle visible
                withAnimation{
                    rectangleVisible = true
                }
            }
        }
    }
}

#Preview {
    Exp8_timer_action()
}
