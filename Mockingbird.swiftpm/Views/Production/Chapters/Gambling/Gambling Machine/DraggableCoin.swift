//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct DraggableCoin: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State private var circlePosition: CGPoint? // Make circlePosition optional
    @State var hasCollided: Bool = false
    
    @Binding var isCoinInsertedInMachine: Bool
    @Binding var isInHeaven: Bool
    
    var insertCoin: () -> Void
    var rectCollider: CGRect
    
    var body: some View {
        let circleSize: CGFloat = 100
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        if !hasCollided{
            GeometryReader { geometry in
                Circle()
                    .position(circlePosition ?? initialLocation)
                    .foregroundColor(.red)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                circlePosition = value.location
                                
                                let globalX: Double = geometry.frame(in: .global).origin.x + value.location.x - circleSize/2
                                let globalY: Double = geometry.frame(in: .global).origin.y + value.location.y - circleSize/2
                                let coinCollider = CGRect(x: globalX, y: globalY, width: circleSize, height: circleSize)
                                
                                checkCollision(coinCollider: coinCollider, rectCollider: rectCollider)
                            }
                            .onEnded { _ in
                                withAnimation {
                                    circlePosition = initialLocation
                                }
                            }
                    )
            }
            .frame(width: circleSize, height: circleSize)
            .transition(.asymmetric(insertion: .identity, removal: .scale(scale: 0.1)))
        }
    }
    
    func checkCollision(coinCollider: CGRect, rectCollider: CGRect) {
        if isInHeaven{
            return
        }
        
        guard notificationManager.isTextPrintFinished else {
            return
        }

        guard coinCollider.intersects(rectCollider) && !hasCollided && !isCoinInsertedInMachine else {
            return
        }

        withAnimation {
            withAnimation{
                hasCollided = true
            }
            insertCoin()
        }
    }

}
