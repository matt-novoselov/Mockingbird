//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct StartMenu: View {
    var transitionToScene: (Int) -> Void
    
    var jigglingArray: [String] = ["num1", "num2", "num3", "num4"]
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            Button(action: {transitionToScene(2)}) {
                Image(jigglingArray[currentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                            currentIndex = (currentIndex + 1) % jigglingArray.count
                        }
                    }
            }
            
        }
    }
}


#Preview {
    StartMenu(transitionToScene: TransitionManager().transitionToScene)
}
