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
        ZStack{
            Rectangle()
                .fill(.blue)
                .ignoresSafeArea()
            
            HStack {
                Text("lorem ipsum")
                
                GeometryReader { geometry in
                    Circle()
                        .onAppear {
                            if let circlePosition = getGlobalPosition(view: geometry) {
                                scene.test_call(xpos: circlePosition.x, ypos: -circlePosition.y)
                            }
                        }
                }
                .frame(width: 30, height: 30)
                
                Text("lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum")
            }
        }
        .onTapGesture(coordinateSpace: .global) { location in
            scene.test_call(xpos: location.x, ypos: location.y)
        }
    }
    
    private func getGlobalPosition(view: GeometryProxy) -> CGPoint? {
        let circleRect = view.frame(in: .global)
        return CGPoint(x: circleRect.midX, y: circleRect.midY)
    }
}

#Preview {
    SK_app_layer(scene: .constant(SK_Game_Layer()))
}
