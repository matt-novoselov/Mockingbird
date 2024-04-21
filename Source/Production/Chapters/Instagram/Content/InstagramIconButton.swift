//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 13/02/24.
//

import SwiftUI

// View for reactions used in instagram scene. Appears in game as "like", "comment" or "forward"
struct InstagramIconButton: View {
    
    // Main symbol
    var symbol: String
    
    // Filled version of the main symbol
    var filledSymbol: String
    
    // Action that should be performed after clicking the symbol
    var action: () -> Void
    
    // Property that ensures singletons performance of the button
    @State var isButtonPressed: Bool = false
    
    // Property that controls if 1 of 3 buttons were already clicked
    @Binding var isOneOfButtonsPressed: Bool
    
    // Get current post ID under which the reactions are being displayed
    @Binding var currentPostID: Int
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        
        // Geometry Reader wrapper to get the global position of the button on screen
        GeometryReader { geometry in
            Button(
                action: {
                    
                    // Prevent accidential button clicks
                    if notificationManager.isTextPrintFinished == false{
                        return
                    }
                    
                    // Perform action only the first time
                    if isButtonPressed{
                        return
                    }
                    
                    // Ensure only 1 of 3 buttons can call action
                    if !isOneOfButtonsPressed{
                        action()
                    }
                    
                    // Play sound effect
                    playSound(name: "Like_Button", ext: "mp3")

                    withAnimation(Animation.easeInOut(duration: 0.2)){
                        isButtonPressed = true
                        isOneOfButtonsPressed = true
                    }
                    
                    // Spawn particles animation
                    if let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                        ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
                    }

                }
            )
            {
                Image(!isButtonPressed ? symbol : filledSymbol)
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .glow(color: Color("MainYellow").opacity(isButtonPressed ? 0.3 : 0), radius: 30)
            }
            .buttonStyle(NoOpacityButtonStyle())
        }
        .frame(width: 45, height: 45)
        
    }
}
