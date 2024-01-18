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
                .frame(width: 200, height: 200)
                .foregroundColor(.yellow)
            
            DraggableCircles()
        }
    }
}

struct DraggableCircles: View {
    private var InitLocation: CGPoint = CGPoint(x: 50, y: 50)
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @GestureState private var startLocation: CGPoint? = nil
    
    var body: some View {
        
        // Here is create DragGesture and handel jump when you again start the dragging/
        let dragGesture = DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
            .onEnded{_ in
                withAnimation{
                    location=InitLocation
                }
            }
        
        return Circle().fill(Color.red)
            .frame(width: 100, height: 100)
            .position(location)
            .gesture(dragGesture)
            .padding()
    }
}

#Preview {
    Exp16_drag_view()
}
