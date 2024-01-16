//
//  SK_app_layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct SK_app_layer: View {
    @Binding var scene: SK_Game_Layer
    
    var body: some View {
        Rectangle()
            .fill(.blue)
            .ignoresSafeArea()
            .onTapGesture(coordinateSpace: .global) { location in
                scene.test_call(xpos: location.x, ypos: location.y)
            }
    }
}

#Preview {
    SK_app_layer(scene: .constant(SK_Game_Layer()))
}
