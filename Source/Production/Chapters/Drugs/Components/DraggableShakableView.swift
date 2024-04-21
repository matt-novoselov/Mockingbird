//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct DraggableShakableView: View {
    
    // Control the position of the box at the scene
    @State private var boxPosition: CGPoint?
    
    // Value that controls if the box is currently being held
    @State var viewIsHeld: Bool = false
    
    // Opacity of the glowing effect
    @State private var glowingOpacity: Double = 0.25
    
    // Action that happens after the box was shaken
    var handleShake: () -> Void
    
    var body: some View {
        
        // Adjust the size if the collider
        let boxSize: CGFloat = 400
        let initialLocation = CGPoint(x: boxSize / 2, y: boxSize / 2)
        
        Image("pills_box")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(Angle(degrees: viewIsHeld ? 65 : 0))
            .position(boxPosition ?? initialLocation)
            .frame(width: boxSize, height: boxSize)
            .foregroundColor(.red)
            .glow(color: Color("MainYellow").opacity(glowingOpacity), radius: 100)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                    self.glowingOpacity = 0.15
                }
            }
        
            // Drag gesture that returns box to the initial position on release
            .gesture(
                DragGesture()
                    .onChanged { value in
                        boxPosition = value.location
                        
                        CheckShake(value: value)
                        
                        withAnimation(.easeOut(duration: 0.5)){
                            viewIsHeld = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            boxPosition = initialLocation
                        }
                        
                        withAnimation(.easeOut(duration: 0.5)){
                            viewIsHeld = false
                        }
                    }
            )
    }
    
    // Function that checks shaking force and performs an action
    func CheckShake(value: DragGesture.Value){
        let velocityForce: CGFloat = 1500
        
        if (abs(value.velocity.height) > velocityForce || abs(value.velocity.width) > velocityForce){
            handleShake()
        }
    }
}
