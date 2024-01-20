//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI
import SpriteKit

struct SK_Combine: View {
    @State private var scene = SK_Game_Layer()
    
    var body: some View {
        ZStack {
            SK_app_layer(scene: $scene)
            
            SpriteView(
                scene: scene,
                options: [.allowsTransparency]
            )
            .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SK_Combine()
}
