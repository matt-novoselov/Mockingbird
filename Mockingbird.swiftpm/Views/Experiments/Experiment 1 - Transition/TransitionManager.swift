//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct TransitionManager: View {
    @State private var currentSceneID: Int = 0
    
    var body: some View {
        VStack{
            Group{
                switch currentSceneID {
                case 0:
                    View1(transitionToScene: transitionToScene)
                case 1:
                    View2(transitionToScene: transitionToScene)
                case 2:
                    View3(transitionToScene: transitionToScene)
                default:
                    Text("Error, this sceneID doesn't exist")
                }
            }
            .transition(.pushUpTransition)
            
        }
        .ignoresSafeArea()
    }
    
    func transitionToScene(newSceneID: Int) {
        withAnimation(.easeInOut(duration: 2)) {
            currentSceneID = newSceneID
        }
    }
}

#Preview {
    TransitionManager()
}
