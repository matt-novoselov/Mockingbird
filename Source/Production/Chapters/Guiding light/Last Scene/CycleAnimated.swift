//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 02/02/24.
//

import SwiftUI

struct CycleAnimated: View {
    
    // Amount of degrees wipe for arrow 1
    @State var degreesAmount1: Double = 0.75
    
    // Amount of degrees wipe for arrow 2
    @State var degreesAmount2: Double = 0.75
    
    // Opacity of the diagram text 1
    @State var textOpacity1: Double = 0
    
    // Opacity of the diagram text 2
    @State var textOpacity2: Double = 0
    
    // Height of the frame to display text in based on height of geomtryHolder
    @State var frameHeight: Double = 0
    
    // Property that controls id the arrow pointer is being displayed
    @State var isPointer1displayed: Bool = false
    
    // Property that controls id the arrow pointer is being displayed
    @State var isPointer2displayed: Bool = false
    
    // Holder for Geometry Proxy
    @State var geomtryHolder: GeometryProxy?
    
    var body: some View {
        
        ZStack{
            HStack{
                ArrowAnimated(degreesAmount: $degreesAmount1, isPointerDisplayed: $isPointer1displayed)
                    .background(
                        GeometryReader{ proxy in
                            Color.clear
                            
                                // Adjust frame height
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
                                
                                    // Link geomtry Holder to the value
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
                
                ArrowAnimated(degreesAmount: $degreesAmount2, isPointerDisplayed: $isPointer2displayed)
                    .rotationEffect(Angle(degrees: 180))
            }
        }
        
        // Play aniamtion on appear
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
                        isPointer1displayed = true
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
                                isPointer2displayed = true
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}


// View for animated arrow for diagram
struct ArrowAnimated: View {
    
    // Property that controls if arrow is being animated
    @State private var isAnimating = false
    
    // Scale of the arrow pointer
    @State private var scalePointer: Double = 0
    
    // Amount of degrees wipe for arrow
    @Binding var degreesAmount: Double
    
    // Property that controls id the arrow pointer is being displayed
    @Binding var isPointerDisplayed: Bool
    
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
                            if isPointerDisplayed {
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
