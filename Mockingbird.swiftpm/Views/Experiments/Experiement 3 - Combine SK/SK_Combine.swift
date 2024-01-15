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
        
        ZStack{
            SK_app_layer()
            
            SpriteView(
                scene: SK_Game_Layer(size: CGSize(width: 500, height: 500)),
                options: [.allowsTransparency]
            )
        }
        
    }
}

#Preview {
    SK_Combine()
}
