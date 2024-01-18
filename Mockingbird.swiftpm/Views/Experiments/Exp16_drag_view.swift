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
            DraggableCircle()
                .background(.blue)
            
            DraggableCircle()
                .background(.blue)
            
            DraggableCircle()
                .background(.blue)
        }
    }
}

struct DraggableCircle: View {
    @State private var InitLocation: CGPoint = CGPoint(x: 50, y: 50)
    @State private var circlePosition: CGPoint? // Make circlePosition optional
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .foregroundColor(.red)
                .position(circlePosition ?? InitLocation)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            circlePosition = value.location
                        }
                        .onEnded { _ in
                            withAnimation {
                                circlePosition = InitLocation
                            }
                        }
                )
        }
        .frame(width: 100, height: 100)
    }
}


#Preview {
    Exp16_drag_view()
}
