//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp16_drag_view: View {
    var body: some View {
        VStack{
            HStack{
                VStack{
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

struct DraggableCircle: View {
    @State private var circlePosition: CGPoint? // Make circlePosition optional
    
    var body: some View {
        let circleSize: CGFloat = 100
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        return Circle()
            .foregroundColor(.red)
            .position(circlePosition ?? initialLocation)
            .frame(width: circleSize, height: circleSize)
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

#Preview {
    Exp16_drag_view()
}
