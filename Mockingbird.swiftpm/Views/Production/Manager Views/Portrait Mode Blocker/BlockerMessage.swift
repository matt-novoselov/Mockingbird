//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

// Message that will be displayed when the device is in incorrect orientation
struct BlockerMessage: View {
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            VStack (spacing: 0){
                Image("SF_orientation")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 95)
                
                FontText(text: "Better experience in the landscape mode", size: 64)
                    .multilineTextAlignment(.center)
                    .padding()
            }

        }
    }
}

#Preview {
    BlockerMessage()
}
