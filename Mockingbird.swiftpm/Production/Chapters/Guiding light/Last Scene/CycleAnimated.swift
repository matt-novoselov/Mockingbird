//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 02/02/24.
//

import SwiftUI

struct CycleAnimated: View {
    @State var degreesAmount1: Double = 0.75
    @State var degreesAmount2: Double = 0.75
    @State var textOpacity1: Double = 0
    @State var textOpacity2: Double = 0
    @State var frameHeight: Double = 0
    
    @State var pointer1: Bool = false
    @State var pointer2: Bool = false
    
    @State var geomtryHolder: GeometryProxy?
    
    var body: some View {
        
        ZStack{
            HStack{
                ArrowAnimated(degreesAmount: $degreesAmount1, pointer: $pointer1)
                    .background(
                        GeometryReader{ proxy in
                            Color.clear
                                .onAppear(){
                                    frameHeight = proxy.size.height
                                }
                        }
                    )
                
                VStack{
                    Image("dopamine_cropped_text")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .opacity(textOpacity1)
                        .background(
                            GeometryReader{ geometry in
                                Color.clear
                                    .onAppear(){
                                        geomtryHolder = geometry
                                    }
                            }
                        )
                    
                    Spacer()
                    
                    Image("addicted_cropped_text")
                        .interpolation(.high)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(textOpacity2)
                }
                .frame(maxHeight: frameHeight==0 ? .infinity : frameHeight)
                
                ArrowAnimated(degreesAmount: $degreesAmount2, pointer: $pointer2)
                    .rotationEffect(Angle(degrees: 180))
            }
        }
        .onAppear(){
            
            withAnimation(.easeInOut(duration: 0.25)) {
                textOpacity1 = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                
                if let geometryHolder = geomtryHolder,
                   let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometryHolder) {
                    ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
                }
                
                withAnimation(.easeInOut(duration: 2.0)){
                    degreesAmount1 = 0.25
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.none){
                        pointer1 = true
                    }
                    withAnimation(.easeInOut(duration: 0.25)) {
                        textOpacity2 = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation(.easeInOut(duration: 2.0)){
                            degreesAmount2 = 0.25
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            
                            if let geometryHolder = geomtryHolder,
                               let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometryHolder) {
                                ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
                            }
                            
                            withAnimation(.none){
                                pointer2 = true
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}


struct ArrowAnimated: View {
    @State private var isAnimating = false
    @State private var scalePointer: Double = 0
    @Binding var degreesAmount: Double
    @Binding var pointer: Bool
    
    var body: some View {
        ZStack{
            Image("arrow_curved")
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask(
                    GeometryReader{ proxy in
                        Circle()
                            .offset(x: proxy.size.width/2)
                            .trim(from: degreesAmount, to: 0.75) // 1
                            .stroke(
                                lineWidth: 1000
                            )
                    }
                )
                .padding(.vertical, 40)
                .background(
                    HStack{
                        Spacer()
                        
                        VStack{
                            Spacer()
                            if pointer {
                                Image("pointer")
                                    .interpolation(.high)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(scalePointer, anchor: .trailing)
                                    .frame(width: 75)
                                    .onAppear(){
                                        withAnimation(.easeInOut){
                                            scalePointer = 1
                                        }
                                    }
                            }
                        }
                    }
                )
                .padding(.horizontal, 50)
        }
    }
}


#Preview {
    CycleAnimated()
}
