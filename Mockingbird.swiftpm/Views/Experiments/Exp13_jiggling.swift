//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp13_jiggling: View {
    var jigglingArray: [String] = ["num1", "num2", "num3", "num4"]
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            Color(.green)
                .ignoresSafeArea()
            
            Image(jigglingArray[currentIndex])
                .onAppear {
                    // Use Timer to update the displayed image every 0.1 seconds
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                        currentIndex = (currentIndex + 1) % jigglingArray.count
                    }
                }
        }
    }
}


#Preview {
    Exp13_jiggling()
}
