//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct DraggableShakableView: View {
    @State private var circlePosition: CGPoint?
    
    var handleShake: () -> Void
    
    var body: some View {
        let circleSize: CGFloat = 100
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        Circle()
            .position(circlePosition ?? initialLocation)
            .frame(width: circleSize, height: circleSize)
            .foregroundColor(.red)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        circlePosition = value.location
                        
                        CheckShake(value: value)
                    }
                    .onEnded { _ in
                        withAnimation {
                            circlePosition = initialLocation
                        }
                    }
            )
            .background(.blue)
    }
    
    func CheckShake(value: DragGesture.Value){
        if (abs(value.velocity.width) > 4000 && abs(value.velocity.height) > 4000){
            handleShake()
        }
    }
}

#Preview {
    DraggableShakableView(handleShake: DrugsScene().handleShake)
}
