//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 20/01/24.
//

import SwiftUI

struct InstagramViewController: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    @State private var currentPostID: Int = 0
    var posts:InstagramPostViewModel = InstagramPostViewModel()
    
    var action: () -> Void
    
    @Binding var shouldChangePost: Bool
    
    var body: some View {
        VStack{
            Group{
                switch currentPostID {
                case 0:
                    let selectedPost = posts.posts[0]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action)
                case 1:
                    let selectedPost = posts.posts[1]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action)
                case 2:
                    let selectedPost = posts.posts[2]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action)
                case 3:
                    let selectedPost = posts.posts[3]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action)
                default:
                    Text("Error, this sceneID doesn't exist")
                }
            }
            .padding()
            .transition(.pushLeftTransition)
            .environmentObject(notificationManager)
        }
        .onChange(of: shouldChangePost){
            transitionToNextPost()
        }
        .background(.orange)
    }
    
    func transitionToNextPost() {
        withAnimation(.easeInOut(duration: 1)) {
            if currentPostID<posts.posts.count-1{
                currentPostID += 1
            }
        }
    }
}

#Preview {
    LayersManager(initialView: InstagramViewController(action: InstagramScene().handleOnReaction, shouldChangePost: .constant(false)))
}
