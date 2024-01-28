//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct DraggableShakableView: View {
    @State private var circlePosition: CGPoint?
    @State var viewIsHeld: Bool = false
    
    var handleShake: () -> Void
    
    var body: some View {
        let circleSize: CGFloat = 400
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        Image("PH_drugs_box")
            .interpolation(.high)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(Angle(degrees: viewIsHeld ? 65 : 0))
            .position(circlePosition ?? initialLocation)
            .frame(width: circleSize, height: circleSize)
            .foregroundColor(.red)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        circlePosition = value.location
                        
                        CheckShake(value: value)
                        
                        withAnimation{
                            viewIsHeld = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            circlePosition = initialLocation
                        }
                        
                        withAnimation{
                            viewIsHeld = false
                        }
                    }
            )
//            .background(.blue)
    }
    
    func CheckShake(value: DragGesture.Value){
        if (abs(value.velocity.height) > 6000){
            handleShake()
        }
    }
}
