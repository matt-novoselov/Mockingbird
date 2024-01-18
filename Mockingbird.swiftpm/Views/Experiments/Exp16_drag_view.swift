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

        GeometryReader { geometry in
            Circle()
                .foregroundColor(.red)
//                .background(GeometryReader { geometry in
//                    Color.clear
//                        .onChange(of: geometry.frame(in: .global)) { newLocalRect in
//                            
//                            
//                                                    
//                            if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                                let newGlobalRect = geometry.frame(in: .global).applying(window.screen.coordinateSpace as! CGAffineTransform)
//                                print(newGlobalRect)
//                            }
//                            
//
//                        }
//                })
                .position(circlePosition ?? initialLocation)
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
        .frame(width: circleSize, height: circleSize)
    }
}
