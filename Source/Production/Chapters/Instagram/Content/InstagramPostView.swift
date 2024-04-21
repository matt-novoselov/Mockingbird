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
    @Binding var currentPostID: Int 
    @State var isOneOfTheButtonsPressed: Bool = false
    
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
                InstagramIconButton(symbol: "SF_chat", filledSymbol: "SF_chat_filled", action: {action()}, isOneOfButtonsPressed: $isOneOfTheButtonsPressed, currentPostID: $currentPostID)
                
                Spacer()
                
                InstagramIconButton(symbol: "SF_like", filledSymbol: "SF_like_filled", action: {action()}, isOneOfButtonsPressed: $isOneOfTheButtonsPressed, currentPostID: $currentPostID)
                
                Spacer()
                
                InstagramIconButton(symbol: "SF_forward", filledSymbol: "SF_forward_filled", action: {action()}, isOneOfButtonsPressed: $isOneOfTheButtonsPressed, currentPostID: $currentPostID)
            }
            .environmentObject(notificationManager)
        }
    }
}

#Preview {
    LayersManager(
        initialView: InstagramPostView(username: "@example", postedTimeAgo: "ex ago", image: "PH_calendar", action: InstagramViewController(action: InstagramScene().handleOnReaction, shouldChangePost: .constant(false)).transitionToNextPost, currentPostID: .constant(0))
    )
    .frame(width: 500, height: 500)
}
