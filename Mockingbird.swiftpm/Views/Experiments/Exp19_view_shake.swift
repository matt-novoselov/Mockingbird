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
            Text("Something fell out")
                .opacity(0.8)
            
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
                        if (abs(value.velocity.width) > 4000 && abs(value.velocity.height) > 4000){
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
