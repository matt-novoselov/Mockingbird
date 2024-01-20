//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct Exp19_view_shake: View {
    @State var isShaken: Bool = false
    
    var body: some View {
        VStack{
            Text("Something fell out")
                .opacity(isShaken ? 1 : 0)
            
            DraggableCircle2(isShaken: $isShaken)
        }
    }
}

struct DraggableCircle2: View {
    @State private var circlePosition: CGPoint?
    @Binding var isShaken: Bool
    
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
                            isShaken = true
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
