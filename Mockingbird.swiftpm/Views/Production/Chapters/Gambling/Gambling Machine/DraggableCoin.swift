//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct DraggableCoin: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var circlePosition: CGPoint?
    @State var hasCollided: Bool = false
    
    @Binding var isCoinInsertedInMachine: Bool
    @Binding var isInHeaven: Bool
    
    var insertCoin: () -> Void
    var centerOfScreen :CGPoint
    
    @State var hasReachedCollider: Bool = false
    
    var body: some View {
        let circleSize: CGFloat = 100
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        if !hasCollided{
            GeometryReader { geometry in
                Circle()
                    .scaleEffect(hasReachedCollider ? 0 : 1)
                    .position(circlePosition ?? initialLocation)
                    .foregroundColor(.red)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if hasReachedCollider{
                                    return
                                }
                                
                                circlePosition = value.location
                                
                                let globalX: Double = geometry.frame(in: .global).origin.x + value.location.x - circleSize/2
                                let globalY: Double = geometry.frame(in: .global).origin.y + value.location.y - circleSize/2
                                let coinCollider = CGRect(x: globalX, y: globalY, width: circleSize, height: circleSize)
                                
                                checkCollision(coinCollider: coinCollider, centerOfScreen: centerOfScreen)
                            }
                            .onEnded { _ in
                                if !hasReachedCollider{
                                    withAnimation {
                                        circlePosition = initialLocation
                                    }
                                }
                            }
                    )
            }
            .frame(width: circleSize, height: circleSize)
        }
    }
    
    func checkCollision(coinCollider: CGRect, centerOfScreen: CGPoint) {
        if isInHeaven{
            return
        }
        
        guard notificationManager.isTextPrintFinished else {
            return
        }
        
        let rectCollider = CGRect(x: centerOfScreen.x, y: centerOfScreen.y, width: 200, height: 200)
        
        guard coinCollider.intersects(rectCollider) && !hasCollided && !isCoinInsertedInMachine else {
            return
        }
        
        insertCoin()
        
        withAnimation{
            hasReachedCollider = true
        } completion: {
            withAnimation{
                hasCollided = true
            }
        }
        
    }
}
