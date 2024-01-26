//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct PiggyBankScene: View {
    var switchScene: () -> Void
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0.15), heavenSlider: .constant(0))
            
            VStack{
                Text("PiggyBankScene")
                
                Button("Go back")
                {
                    switchScene()
                }
            }
        }
    }
}

#Preview {
    PiggyBankScene(switchScene: {})
}
