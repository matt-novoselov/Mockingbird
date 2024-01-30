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
    
    var body: some View {
        HStack{
            singleSlot()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear(){
                                imageSize = proxy.size
                                offsetY = -imageSize.height
                            }
                    }
                )
                .offset(y: offsetY / 2)
            
            singleSlot()
                .offset(y: offsetY / 2 - 100)
            
            singleSlot()
                .offset(y: offsetY / 2 + 100)
        }
    }
    
    public func rotateSlots(){
        withAnimation(.easeInOut(duration: 5)) {
            offsetY = imageSize.height
        }
    }
}

struct singleSlot: View {
    var body: some View {
        Image("slots")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100)
    }
}


#Preview {
    SlotsRotation()
}
