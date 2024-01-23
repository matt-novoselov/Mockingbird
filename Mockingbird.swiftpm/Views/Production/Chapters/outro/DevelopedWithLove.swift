//
//  SK_app_layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct DevelopedWithLove: View {
    @Binding var scene: GameLayer
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .ignoresSafeArea()
            
            HStack {
                Text("Developed with")
                
                GeometryReader { geometry in
                    Circle()
                        .onAppear {
                            if let circlePosition = getGlobalPosition(view: geometry) {
                                scene.test_call(xpos: circlePosition.x, ypos: -circlePosition.y)
                            }
                        }
                }
                .frame(width: 30, height: 30)
                
                Text("by Matt Novoselov")
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
    DevelopedWithLove(scene: .constant(GameLayer()))
}
