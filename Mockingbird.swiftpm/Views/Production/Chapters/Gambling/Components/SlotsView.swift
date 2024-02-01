//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 30/01/24.
//

import SwiftUI

struct SlotsRotation: View {
    @State private var offsetY: CGFloat = 0
    @State var imageSize: CGSize = CGSize(width: 0, height: 0)
    @Binding var changeBool: Bool
    @State var firstVariation: Bool = false
    
    public let animationDuration: Double = 2.0
    
    let amountOfFruits: Int = 26
    
    var body: some View {
        ZStack{
            Image("slots")
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear(){
                                imageSize = proxy.size
                                offsetY = imageSize.height - imageSize.height / CGFloat(amountOfFruits)
                            }
                    }
                )
                .offset(y: offsetY / 2)
                .onChange(of: changeBool){
                    rotateSlots()
                }
            
//            Button("Button") {
//                rotateSlots()
//            }
        }
    }
    
    public func rotateSlots(){
        if firstVariation{
            withAnimation(.spring(duration: animationDuration)) {
                offsetY = imageSize.height - imageSize.height / CGFloat(amountOfFruits)
            }
        }
        else{
            withAnimation(.spring(duration: animationDuration)) {
                offsetY = -imageSize.height + imageSize.height / CGFloat(amountOfFruits)
            }
        }
        
        firstVariation.toggle()
    }
}

#Preview {
    SlotsRotation(changeBool: .constant(false))
}
