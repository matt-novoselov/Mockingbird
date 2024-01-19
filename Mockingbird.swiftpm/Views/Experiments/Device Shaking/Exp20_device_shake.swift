//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

// An example view that responds to being shaken
struct Exp20_device_shake: View {
    @State var isShaken: Bool = false
    
    var body: some View {
        VStack{
            Text("Something fell out")
                .opacity(isShaken ? 1 : 0)
            
            Text("Shake me!")
        }
        .onShake {
            isShaken = true
        }
    }
}

#Preview{
    Exp20_device_shake()
}
