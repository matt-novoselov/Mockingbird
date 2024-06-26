//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

// This is a View that handles transitions between different Views
struct TransitionManager: View {
    
    // Initiate Transition Manager
    @StateObject private var transitionManagerObservable = TransitionManagerObservable()
    
    // The ID of the currently displayed scene
    @State private var currentSceneID: Int = 0
    
    // Animation duration
    let transitionDuration: Double = 1.5
    
    var body: some View {
        VStack{
            Group{
                switch currentSceneID {
                case 0:
                    BetterExperienceInLandscape()
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
                    Text("Placeholder ID")
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
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // Function that transitions from one scene to another
    func transitionToScene(newSceneID: Int) {
        withAnimation(.easeInOut(duration: transitionDuration)) {
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
    LayersManager(initialView: TransitionManager())
}
