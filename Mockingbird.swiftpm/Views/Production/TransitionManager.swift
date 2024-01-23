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
                    BetterExperienceInHeadphones(transitionToScene: transitionToScene)
                case 1:
                    StartMenu(transitionToScene: transitionToScene)
                case 2:
                    EachYearStatistics(transitionToScene: transitionToScene)
                case 3:
                    CookieScene(transitionToScene: transitionToScene)
                case 4:
                    AlcoholScene(transitionToScene: transitionToScene)
                case 5:
                    InstagramScene(transitionToScene: transitionToScene)
                case 6:
                    GamblingScene(transitionToScene: transitionToScene)
                case 7:
                    Text("Placeholder ID")
                case 8:
                    DrugsScene(transitionToScene: transitionToScene)
                case 9:
                    LightBlinking(transitionToScene: transitionToScene)
                case 10:
                    YouAreNotAlone(transitionToScene: transitionToScene)
                case 11:
                    PianoScene(transitionToScene: transitionToScene)
                case 12:
                    FamilyScene(transitionToScene: transitionToScene)
                case 13:
                    LastScene(transitionToScene: transitionToScene)
                case 14:
                    DoYouNeedHelp(transitionToScene: transitionToScene)
                case 15:
                    DevelopedWithLove(transitionToScene: transitionToScene)
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
