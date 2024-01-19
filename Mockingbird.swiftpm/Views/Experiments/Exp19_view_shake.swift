//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct Exp19_view_shake: View {
    var body: some View {
        VStack{
//            GeometryReader{ proxy in
//                
//                    
//            }
//            .background(.green)
//            
            DraggableCircle2()
        }
    }
}

struct DraggableCircle2: View {
    @State private var circlePosition: CGPoint? // Make circlePosition optional
    
    var body: some View {
        let circleSize: CGFloat = 100
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        Circle()
            .position(circlePosition ?? initialLocation)
            .frame(width: circleSize, height: circleSize)
            .foregroundColor(.red)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        circlePosition = value.location
                        if (abs(value.velocity.width) > 6000 && abs(value.velocity.height) > 6000){
                            print("Shaked")
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            circlePosition = initialLocation
                        }
                    }
            )
            .background(.blue)
    }
}

#Preview {
    Exp19_view_shake()
}
