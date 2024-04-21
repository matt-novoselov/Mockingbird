//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct DraggableCoin: View {
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    // Position of the coin in the space
    @State var coinPosition: CGPoint?
    
    // Property that controls is the coin has collided with the collider
    @State var hasCollided: Bool = false
    
    // Property that controls if the coin was inserted to the gambling machine
    @Binding var isCoinInsertedInMachine: Bool
    
    // Property that controls if heaven animation is currently being played
    @Binding var isInHeaven: Bool
    
    // Action that happens after coin was inserted
    var insertCoin: () -> Void
    
    // Property that controls is the coin has reached the collider
    @State var hasReachedCollider: Bool = false
    
    // Holder for Geometry Proxy to determine coin size and position
    @Binding var geometryHolder: GeometryProxy?
    
    // Selected style for coin's texture
    var selectedStyle: Int = 0
    
    var body: some View {
        
        // Adjust coin size
        let circleSize: CGFloat = 100
        let initialLocation = CGPoint(x: circleSize / 2, y: circleSize / 2)
        
        if !hasCollided{
            GeometryReader { geometry in
                Image(selectedStyle == 0 ? "coin_1" : "coin_2")
                    .interpolation(.high)
                    .resizable()
                    .scaleEffect(hasReachedCollider ? 0 : 1)
                    .position(coinPosition ?? initialLocation)
                    .foregroundColor(.red)
                
                    // Gesture to drag coin around the scene that return to initial position on release
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if hasReachedCollider{
                                    return
                                }
                                
                                coinPosition = value.location
                                
                                let globalX: Double = geometry.frame(in: .global).origin.x + value.location.x - circleSize/2
                                let globalY: Double = geometry.frame(in: .global).origin.y + value.location.y - circleSize/2
                                let coinCollider = CGRect(x: globalX, y: globalY, width: circleSize, height: circleSize)
                                
                                if let geometryHolder = geometryHolder {
                                    if let centerOfTheScreen = GlobalPositionUtility.getGlobalPosition(view: geometryHolder) {
                                        checkCollision(coinCollider: coinCollider, centerOfScreen: centerOfTheScreen)
                                    }
                                }

                            }
                            .onEnded { _ in
                                if !hasReachedCollider{
                                    withAnimation {
                                        coinPosition = initialLocation
                                    }
                                }
                            }
                    )
            }
            .frame(width: circleSize, height: circleSize)
        }
    }
    
    // Function that checks if the coin collides with collider
    func checkCollision(coinCollider: CGRect, centerOfScreen: CGPoint) {
        if isInHeaven{
            return
        }
        
        guard notificationManager.isTextPrintFinished else {
            return
        }
        
        let rectCollider = CGRect(x: centerOfScreen.x - 100, y: centerOfScreen.y - 100, width: 200, height: 200)
        
        guard coinCollider.intersects(rectCollider) && !hasCollided && !isCoinInsertedInMachine else {
            return
        }
        
        insertCoin()
        
        withAnimation(.easeInOut(duration: 0.25)) {
            hasReachedCollider = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation{
                hasCollided = true
            }
        }
        
    }
}
