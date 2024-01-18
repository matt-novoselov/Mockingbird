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
            DraggableCircle()
        }
    }
}

struct DraggableCircle: View {
    private var InitLocation: CGPoint = CGPoint(x: 0, y: 0)
    @State private var circlePosition: CGPoint? // Make circlePosition optional
    
    var body: some View {
        Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(.red)
            .position(circlePosition ?? InitLocation) // Use nil coalescing operator to fallback to InitLocation if circlePosition is nil
            .onAppear() {
                circlePosition = InitLocation
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Update the circle position as the finger is dragged
                        circlePosition = value.location
                    }
                    .onEnded { _ in
                        withAnimation {
                            // Reset the circle position when drag ends
                            circlePosition = InitLocation
                        }
                    }
            )
    }
}


#Preview {
    Exp16_drag_view()
}
