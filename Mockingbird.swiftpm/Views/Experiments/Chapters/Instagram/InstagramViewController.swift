//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 20/01/24.
//

import SwiftUI

struct InstagramViewController: View {
    @State private var currentSceneID: Int = 0
    var posts:InstagramPostViewModel = InstagramPostViewModel()
    
    var body: some View {
        VStack{
            Group{
                switch currentSceneID {
                case 0:
                    let selectedPost = posts.posts[0]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, transitionToScene: transitionToNextPost)
                case 1:
                    let selectedPost = posts.posts[1]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, transitionToScene: transitionToNextPost)
                case 2:
                    let selectedPost = posts.posts[2]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, transitionToScene: transitionToNextPost)
                case 3:
                    let selectedPost = posts.posts[3]
                    InstagramPostView(username: selectedPost.username, postedTimeAgo: selectedPost.postedTimeAgo, image: selectedPost.image, transitionToScene: transitionToNextPost)
                default:
                    Text("Error, this sceneID doesn't exist")
                }
            }
            .transition(.pushLeftTransition)
            
        }
        .padding()
    }
    
    func transitionToNextPost() {
        withAnimation(.easeInOut(duration: 1)) {
            if currentSceneID<posts.posts.count-1{
                currentSceneID += 1
            }
        }
    }
}

#Preview {
    InstagramViewController()
}
