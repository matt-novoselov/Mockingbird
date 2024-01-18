//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp16_drag_view: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.green)
                .frame(width: 100, height: 100)
            
            VStack {
                HStack {
                    VStack {
                        DraggableCircle()
                        DraggableCircle()
                        DraggableCircle()
                    }
                    .padding()
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct DraggableCircle: View {
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

#Preview{
    Exp16_drag_view()
}
