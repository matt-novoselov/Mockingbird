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
    var transitionToScene: () -> Void
    @State var isOneofbuttonsPressed: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                FontText(text: username, size: 20)
                    .foregroundColor(Color("InstagramGray"))
                
                Spacer()
                
                FontText(text: postedTimeAgo, size: 20)
                    .foregroundColor(Color("InstagramGray"))
            }
            
            Image(image)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            
            HStack{
                InstagramIconButton(symbol: "SF_chat", filledSymbol: "SF_chat_filled", action: {transitionToScene()}, isOneOfButtonsPressed: $isOneofbuttonsPressed)
                
                Spacer()
                
                InstagramIconButton(symbol: "SF_like", filledSymbol: "SF_like_filled", action: {transitionToScene()}, isOneOfButtonsPressed: $isOneofbuttonsPressed)
                
                Spacer()
                
                InstagramIconButton(symbol: "SF_forward", filledSymbol: "SF_forward_filled", action: {transitionToScene()}, isOneOfButtonsPressed: $isOneofbuttonsPressed)
                
                
            }
        }
    }
}

struct InstagramIconButton: View {
    var symbol: String
    var filledSymbol: String
    var action: () -> Void
    
    @State var isButtonPressed: Bool = false
    @Binding var isOneOfButtonsPressed: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Button(
                action: {
                    if isOneOfButtonsPressed{
                        return
                    }
                    else{
                        withAnimation(Animation.easeInOut(duration: 0.2)){
                            isButtonPressed = true
                            isOneOfButtonsPressed = true
                        }
                        
                        if let buttonPosition = getGlobalPosition(view: geometry) {
                            ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            action()
                        }
                        
                    }
                }
            )
            {
                Image(!isButtonPressed ? symbol : filledSymbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .glow(color: Color("MB_main_yellow").opacity(isButtonPressed ? 0.3 : 0), radius: 30)
            }
            .buttonStyle(NoOpacityButtonStyle())
        }
        .frame(width: 50, height: 50)
    }
    
    private func getGlobalPosition(view: GeometryProxy) -> CGPoint? {
        let circleRect = view.frame(in: .global)
        return CGPoint(x: circleRect.midX, y: circleRect.midY)
    }
}

#Preview {
    LayersManager(
        initialView: InstagramPostView(username: "@example", postedTimeAgo: "ex ago", image: "PH_calendar", transitionToScene: InstagramViewController().transitionToNextPost)
    )
}
