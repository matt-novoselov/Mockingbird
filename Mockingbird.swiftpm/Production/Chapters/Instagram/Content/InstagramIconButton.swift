//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 13/02/24.
//

import SwiftUI

struct InstagramIconButton: View {
    var symbol: String
    var filledSymbol: String
    var action: () -> Void
    
    @State var isButtonPressed: Bool = false
    @Binding var isOneOfButtonsPressed: Bool
    @Binding var currentPostID: Int
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        GeometryReader { geometry in
            Button(
                action: {
                    if notificationManager.isTextPrintFinished == false{
                        return
                    }
                    
                    if isButtonPressed{
                        return
                    }
                    
                    if !isOneOfButtonsPressed{
                        action()
                    }

                    withAnimation(Animation.easeInOut(duration: 0.2)){
                        isButtonPressed = true
                        isOneOfButtonsPressed = true
                    }
                    
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
