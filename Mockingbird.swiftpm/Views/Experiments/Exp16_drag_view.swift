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
                .frame(width: 100, height: 100)
                .position(x: 75, y: 75)
                .foregroundColor(Color.green)
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        DraggableCircle()
                        DraggableCircle()
                        DraggableCircle()
                    }
                    .padding()
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
        
        GeometryReader { geometry in
            Circle()
                .position(circlePosition ?? initialLocation)
                .foregroundColor(.red)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            circlePosition = value.location
                            let globalX: Double = geometry.frame(in: .global).origin.x + value.location.x
                            let globalY: Double = geometry.frame(in: .global).origin.y + value.location.y
                            let rect2 = CGRect(x: 75, y: 75, width: 100, height: 100)
                            
                            print(CGRect(x: globalX, y: globalY, width: circleSize, height: circleSize).intersects(rect2))
                        }
                        .onEnded { _ in
                            withAnimation {
                                circlePosition = initialLocation
                            }
                        }
                )
        }
        .frame(width: circleSize, height: circleSize)
    }
}

#Preview{
    Exp16_drag_view()
}
