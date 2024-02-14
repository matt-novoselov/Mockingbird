//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct AnimatedHandle: View {
    @State private var rotationAngle: Double = 15
    @State var isAnimationInProcess: Bool = false
    @Binding var isCoinInserted: Bool
    @Binding var isCoinInsertedEarly: Bool
    @State var isCoinInsertedAnimated: Bool = false
    
    var handleResult: () -> Void
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
                .onChange(of: isCoinInserted){ newVal in
                    withAnimation(.easeInOut(duration: 0.5)){
                        isCoinInsertedAnimated = newVal
                    }
                }
        }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                    if (isCoinInserted){
                        idleHandleAnimation()
                    }
                }
            }
    }
    
    func performPostGestureAction(){
        if (isCoinInserted && !isAnimationInProcess){
            rotateHandleAnimation()
        }
        else{
            idleHandleAnimation()
        }
    }
    
    func rotateHandleAnimation(){
        withAnimation(.easeInOut(duration: 1.0)){
            isCoinInsertedEarly = false
        }
        
        if(isAnimationInProcess){
            return
        }
        
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
