//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct AnimatedHandle: View {
    
    // Angle at which the handle is rotated
    @State private var rotationAngle: Double = 15
    
    // Value that controls if animation is currently being played
    @State var isAnimationInProcess: Bool = false
    
    // Value that controls if coin is inserted into the machine
    @Binding var isCoinInserted: Bool
    
    // Value that controls if coin was inserted early
    @Binding var isCoinInsertedEarly: Bool
    
    // Animated property of coin insertion
    @State var isCoinInsertedAnimated: Bool = false
    
    // Action that happens after handle rotation
    var handleResult: () -> Void
    
    // Action that happens if user tries to pull lever without coin being inserted
    var handleNoCoin: () -> Void
    
    var body: some View {
        ZStack{
            Image("gambling_handle")
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(.degrees(rotationAngle), anchor: .bottom)
                .overlay(){
                    Color.clear
                        .contentShape(Rectangle())
                        .background(.blue.opacity(0.0))
                        .padding(.all, -40) // handle hitbox
                        .rotationEffect(.degrees(rotationAngle), anchor: .bottom)
                    
                    // Rotate handle on tap or slide
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    performPostGestureAction()
                                }
                                .exclusively(before: DragGesture()
                                    .onEnded { value in
                                        if value.translation.height > 0 {
                                            performPostGestureAction()
                                        }
                                    }
                                )
                        )
                    
                }
            
            Image("handle_overlay")
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .allowsHitTesting(false)
                .rotationEffect(.degrees(rotationAngle), anchor: .bottom)
                .glow(color: Color("MainYellow").opacity(0.8), radius: 50)
                .opacity(isCoinInsertedAnimated ? 1 : 0)
                .onChange(of: isCoinInserted){
                    withAnimation(.easeInOut(duration: 0.5)){
                        isCoinInsertedAnimated = isCoinInserted
                    }
                }
        }
        // Give a jiggling hint every 5 seconds to indicate that the slot is empty
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                if (isCoinInserted){
                    idleHandleAnimation()
                }
            }
        }
    }
    
    // Handle user interaction with handle
    func performPostGestureAction(){
        if (isCoinInserted && !isAnimationInProcess){
            rotateHandleAnimation()
        }
        else{
            idleHandleAnimation()
        }
    }
    
    // Function for rotating handle animation
    func rotateHandleAnimation(){
        withAnimation(.easeInOut(duration: 1.0)){
            isCoinInsertedEarly = false
        }
        
        if(isAnimationInProcess){
            return
        }
        
        // Play sound effect
        playSound(name: "Lever_Pull", ext: "mp3")
        
        isAnimationInProcess = true
        
        withAnimation(.easeInOut(duration: 1.2)) {
            rotationAngle = 90
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut(duration: 0.4)) {
                rotationAngle = 15
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                isAnimationInProcess = false
                isCoinInserted = false
                handleResult()
            }
        }
    }
    
    // Idle animation for handle (a little bit of jiggling)
    func idleHandleAnimation(){
        if(isAnimationInProcess){
            return
        }
        
        if !isCoinInserted{
            handleNoCoin()
        }
        
        isAnimationInProcess = true
        
        withAnimation(.easeInOut(duration: 0.3)) {
            rotationAngle = 40
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.2)) {
                rotationAngle = 15
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                isAnimationInProcess = false
            }
        }
    }
}

#Preview {
    AnimatedHandle(isCoinInserted: .constant(false), isCoinInsertedEarly: .constant(false), handleResult: GamblingScene().handleResult, handleNoCoin: {})
}
