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
    
    var handleResult: () -> Void
    var handleNoCoin: () -> Void
    
    var body: some View {
//        Rectangle()
//            .frame(width: 20, height: 200)
//            .foregroundColor(.blue)
        Image("gambling_handle")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(.degrees(rotationAngle), anchor: .bottom)
            .onTapGesture {
                if (isCoinInserted && !isAnimationInProcess){
                    rotateHandleAnimation()
                }
                else{
                    idleHandleAnimation()
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
    
    func rotateHandleAnimation(){
        if(isAnimationInProcess){
            return
        }
        
        isAnimationInProcess = true
        withAnimation(.easeInOut(duration: 1.2)) {
            rotationAngle = 90
        } completion: {
            withAnimation(.easeInOut(duration: 0.4)) {
                rotationAngle = 15
                isAnimationInProcess = false
            } completion: {
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
        withAnimation(.easeInOut(duration: 0.2)) {
            rotationAngle = 25
        } completion: {
            withAnimation(.easeInOut(duration: 0.2)) {
                rotationAngle = 15
                isAnimationInProcess = false
            }
        }
    }
}

#Preview {
    AnimatedHandle(isCoinInserted: .constant(false), handleResult: GamblingScene().handleResult, handleNoCoin: {})
}
