//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 20/01/24.
//

import SwiftUI

struct InstagramPostView: View {
    var username: String
    var postedTimeAgo: String
    var image: String
    var action: () -> Void
    @State var isOneofbuttonsPressed: Bool = false
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        VStack (spacing: 0){
            HStack{
                FontText(text: username, size: 18)
                    .foregroundColor(Color("InstagramGray"))
                
                Spacer()
                
                FontText(text: postedTimeAgo, size: 18)
                    .foregroundColor(Color("InstagramGray"))
            }
            
            Image(image)
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding(.vertical)
            
            HStack{
                InstagramIconButton(symbol: "SF_chat", filledSymbol: "SF_chat_filled", action: {action()}, isOneOfButtonsPressed: $isOneofbuttonsPressed)
                
                Spacer()
                
                InstagramIconButton(symbol: "SF_like", filledSymbol: "SF_like_filled", action: {action()}, isOneOfButtonsPressed: $isOneofbuttonsPressed)
                
                Spacer()
                
                InstagramIconButton(symbol: "SF_forward", filledSymbol: "SF_forward_filled", action: {action()}, isOneOfButtonsPressed: $isOneofbuttonsPressed)
            }
            .environmentObject(notificationManager)
        }
    }
}

struct InstagramIconButton: View {
    var symbol: String
    var filledSymbol: String
    var action: () -> Void
    
    @State var isButtonPressed: Bool = false
    @Binding var isOneOfButtonsPressed: Bool
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        GeometryReader { geometry in
            Button(
                action: {
                    if isOneOfButtonsPressed{
                        return
                    }
                    if notificationManager.isTextPrintFinished == false{
                        return
                    }
                    
                    withAnimation(Animation.easeInOut(duration: 0.2)){
                        isButtonPressed = true
                        isOneOfButtonsPressed = true
                    }
                    
                    if let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                        ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
                    }
                    
                    action()
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

#Preview {
    LayersManager(
        initialView: InstagramPostView(username: "@example", postedTimeAgo: "ex ago", image: "PH_calendar", action: InstagramViewController(action: InstagramScene().handleOnReaction, shouldChangePost: .constant(false)).transitionToNextPost)
    )
    .frame(width: 500, height: 500)
}
