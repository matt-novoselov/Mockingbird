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
        ZStack{
            Color(.red)
                .ignoresSafeArea()
            
            Text("Experience is better in the landscape mode")
        }
    }
}

#Preview {
    BlockerMessage()
}
