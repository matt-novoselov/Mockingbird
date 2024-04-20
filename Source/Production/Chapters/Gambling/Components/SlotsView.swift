//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 30/01/24.
//

import SwiftUI

struct SlotsRotation: View {
    
    // Slots image offset on Y axis
    @State private var offsetY: CGFloat = 0
    
    // Autommatically determine slots texture size
    @State var imageSize: CGSize = CGSize(width: 0, height: 0)
    
    // Variable to rotate slots between 2 positions (rotated and idle)
    @Binding var rotateSlotsState: Bool
    
    // Variable to control and switch different variations of slots texture
    @State var firstVariation: Bool = false
    
    // Count how many times slots were rotated
    @State var countRotations: Int = 0
    
    // Adjust animation duration
    public let animationDuration: Double = 2.0
    
    // Amount of fruits in the slots texture
    let amountOfFruits: Int = 26
    
    var body: some View {
        ZStack{
            Image(countRotations < 2 ? "slots" : "slots2")
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(
                    // Determine image size
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear(){
                                imageSize = proxy.size
                                offsetY = imageSize.height - imageSize.height / CGFloat(amountOfFruits)
                            }
                    }
                )
                .offset(y: offsetY / 2)
                .onChange(of: rotateSlotsState){
                    rotateSlots()
                }
        }
    }
    
    // Function to perform slots rotation
    public func rotateSlots(){
        countRotations+=1
        
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
        
        // Toggle texture variation after slots were rotated
        firstVariation.toggle()
    }
}

#Preview {
    SlotsRotation(rotateSlotsState: .constant(false))
}
