//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct TransitionManager: View {
    @StateObject private var transitionManagerObservable = TransitionManagerObservable()
    @State private var currentSceneID: Int = 5
    
    var body: some View {
        VStack{
            Group{
                switch currentSceneID {
                case 0:
                    BetterExperienceInHeadphones()
                case 1:
                    StartMenu()
                case 2:
                    EachYearStatistics()
                case 3:
                    CookieScene()
                case 4:
                    AlcoholScene()
                case 5:
                    InstagramScene()
                case 6:
                    GamblingScene()
                case 7:
                    Text("Placeholder ID")
                case 8:
                    DrugsScene()
                case 9:
                    LightBlinking()
                case 10:
                    YouAreNotAlone()
                case 11:
                    PianoScene()
                case 12:
                    FamilyScene()
                case 13:
                    LastScene()
                case 14:
                    DoYouNeedHelp()
                case 15:
                    DevelopedWithLove()
                default:
                    Text("Error, this sceneID doesn't exist")
                }
            }
            .transition(.pushUpTransition)
        }
        .environmentObject(transitionManagerObservable)
        .onAppear {
            transitionManagerObservable.setTransitionFunction(transitionFunction: transitionToScene)
        }
        .ignoresSafeArea()
    }
    
    func transitionToScene(newSceneID: Int) {
        withAnimation(.easeInOut(duration: 2)) {
            currentSceneID = newSceneID
        }
    }
}

class TransitionManagerObservable: ObservableObject {
    @Published var transitionToScene: ((Int) -> Void)?

    func setTransitionFunction(transitionFunction: @escaping (Int) -> Void) {
        self.transitionToScene = transitionFunction
    }
}

#Preview {
    TransitionManager()
}
