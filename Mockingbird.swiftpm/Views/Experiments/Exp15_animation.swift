//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp15_animation: View {
    @State private var rotationAngle: Double = 0.0
    @State var isCoinInserted: Bool = false
    @State var isAnimationInProcess: Bool = false

    var body: some View {
        VStack{
            Text("Coin: \(isCoinInserted.description)")
            
            Button("Add coin") {
                isCoinInserted = true
            }
            
            Rectangle()
                .frame(width: 20, height: 200)
                .foregroundColor(.blue)
                .rotationEffect(.degrees(rotationAngle), anchor: .bottom)
                .onTapGesture {
                    if (isCoinInserted && !isAnimationInProcess){
                        rotateHandleAnimation()
                        isCoinInserted = false
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

    }
    
    func rotateHandleAnimation(){
        if(isAnimationInProcess){
            return
        }
        
        isAnimationInProcess = true
        withAnimation(.easeInOut(duration: 1.2)) {
            rotationAngle = 90
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut(duration: 0.4)) {
                rotationAngle = 0
                isAnimationInProcess = false
            }
        }
    }
    
    func idleHandleAnimation(){
        if(isAnimationInProcess){
            return
        }
        
        isAnimationInProcess = true
        withAnimation(.easeInOut(duration: 0.2)) {
            rotationAngle = 15
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                rotationAngle = 0
                isAnimationInProcess = false
            }
        }
    }
}

#Preview {
    Exp15_animation()
}
