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
    
    var body: some View {
        
        ZStack{
            HStack{
                ArrowAnimated(degreesAmount: $degreesAmount1)
                
                ArrowAnimated(degreesAmount: $degreesAmount2)
                    .rotationEffect(Angle(degrees: 180))
            }
            
            VStack{
                FontText(text: "Dopamine", size: 90)
                    .opacity(textOpacity1)
                
                Spacer()
                
                FontText(text: "Addicted", size: 90)
                    .opacity(textOpacity2)
            }
        }
        .onAppear(){
            
            withAnimation(.easeInOut){
                textOpacity1 = 1
            }
        completion: {
            withAnimation(.easeInOut(duration: 2.0)){
                degreesAmount1 = 0.25
            }
        completion: {
            withAnimation(.easeInOut){
                textOpacity2 = 1
            }
        completion: {
            withAnimation(.easeInOut(duration: 2.0)){
                degreesAmount2 = 0.25
            }
        }
        }
        }
        }
    }
    
}


struct ArrowAnimated: View {
    @State private var isAnimating = false
    @Binding var degreesAmount: Double
    
    var body: some View {
        Image("arrow_curved")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .mask(
                Circle()
                    .trim(from: degreesAmount, to: 0.75) // 1
                    .stroke(
                        lineWidth: 1000
                    )
            )
    }
}


#Preview {
    //    HStack{
    //        ArrowAnimated(degreesAmount: .constant(0.25))
    //            .background(.red)
    //
    //        FontText(text: "Test", size: 64)
    //
    //        ArrowAnimated(degreesAmount: .constant(0.25))
    //            .background(.green)
    //    }
    
    CycleAnimated()
}
