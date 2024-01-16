//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI
import SpriteKit

struct SK_Combine: View {
    var body: some View {
        @State var scene = SK_Game_Layer()
        
        ZStack{
            SK_app_layer(scene: $scene)
            
            SpriteView(
                scene: scene,
                options: [.allowsTransparency]
            )
            .allowsHitTesting(false)
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    SK_Combine()
}
