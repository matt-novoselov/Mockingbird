//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct DraggableShakableView: View {
    @State private var circlePosition: CGPoint?
    @State var viewIsHeld: Bool = false
    
    @State private var opacity: Double = 0.25
    
    var handleShake: () -> Void
    
    var body: some View {
        let circleSize: CGFloat = 400
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        Image("pills_box")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(Angle(degrees: viewIsHeld ? 65 : 0))
            .position(circlePosition ?? initialLocation)
            .frame(width: circleSize, height: circleSize)
            .foregroundColor(.red)
            .glow(color: Color("MainYellow").opacity(opacity), radius: 100)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                    self.opacity = 0.15
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        circlePosition = value.location
                        
                        CheckShake(value: value)
                        
                        withAnimation(.easeOut(duration: 0.5)){
                            viewIsHeld = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            circlePosition = initialLocation
                        }
                        
                        withAnimation(.easeOut(duration: 0.5)){
                            viewIsHeld = false
                        }
                    }
            )
    }
    
    func CheckShake(value: DragGesture.Value){
        let velocityForce: CGFloat = 2000
        
        if (abs(value.velocity.height) > velocityForce || abs(value.velocity.width) > velocityForce){
            handleShake()
        }
    }
}
