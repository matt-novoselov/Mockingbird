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
    
    var body: some View {
        VStack{
            HStack{
                Text(username)
                
                Spacer()
                
                Text(postedTimeAgo)
            }
            
            Image(image)
                .resizable()
                .scaledToFill()
            
            HStack{
                Button("comment") {
                    transitionToScene()
                }

                Spacer()
                
                Button("like") {
                    transitionToScene()
                }
                
                Spacer()
                
                Button("share") {
                    transitionToScene()
                }
            }
        }
    }
}

#Preview {
    InstagramPostView(username: "@example", postedTimeAgo: "ex ago", image: "PH_calendar", transitionToScene: InstagramViewController().transitionToNextPost)
}
