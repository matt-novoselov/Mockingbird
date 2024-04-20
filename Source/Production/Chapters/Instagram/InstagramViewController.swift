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
    
    // ID of the current Instagram post displayed in the scene
    @State var currentPostID: Int = 0
    
    // Load all posts from the View Model
    var posts: InstagramPostViewModel = InstagramPostViewModel()
    
    // Variable that handles action that should happen after posting the reaction (transition to the scene or call notification)
    var action: () -> Void
    
    @Binding var shouldChangePost: Bool
    
    var body: some View {
        VStack{
            Group{
                // Display according post based on the post ID
                switch currentPostID {
                case 0:
                    let selectedPost = posts.posts[0]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action, currentPostID: $currentPostID)
                case 1:
                    let selectedPost = posts.posts[1]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action, currentPostID: $currentPostID)
                case 2:
                    let selectedPost = posts.posts[2]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action, currentPostID: $currentPostID)
                case 3:
                    let selectedPost = posts.posts[3]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, action: action, currentPostID: $currentPostID)
                default:
                    Text("Error, this sceneID doesn't exist")
                }
            }
            .transition(.pushLeftTransition)
            .environmentObject(notificationManager)
            .padding(.horizontal, 25)
        }
        .onChange(of: shouldChangePost){
            transitionToNextPost()
        }
    }
    
    // Function to transition to the next Instagram post
    func transitionToNextPost() {
        withAnimation(.easeInOut(duration: 1)) {
            if currentPostID<posts.posts.count-1{
                currentPostID += 1
            }
        }
    }
}
