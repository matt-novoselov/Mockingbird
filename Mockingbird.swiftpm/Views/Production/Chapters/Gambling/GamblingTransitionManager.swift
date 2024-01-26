//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 25/01/24.
//

import SwiftUI

struct GamblingTransitionManager: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var isPiggyBankScene: Bool = true
//    @State var switchHappened: Bool = false

    var body: some View {
        ZStack{
            Group{
                if isPiggyBankScene{
                    PiggyBankScene(switchScene: switchScene)
                        .transition(.move(edge: .leading))
                }
                else{
                    GamblingScene()
                        .transition(.move(edge: .trailing))

                    //                            .transition(.move(edge: .trailing))
//                    if switchHappened{
//                        GamblingScene(darkSlider: 0.5, countVisitsToHeaven:2, amountOfCoinsOnStart: 1, showingCoins: true, switchScene: switchScene)
//                            .transition(.move(edge: .trailing))
//                    }
//                    else{
//                        GamblingScene(switchScene: switchScene)
//                            .transition(.move(edge: .trailing))
//                    }
                }
            }
            .environmentObject(transitionManagerObservable)
            .environmentObject(notificationManager)
        }
        .ignoresSafeArea()
    }
    
    func switchScene(){
        notificationManager.closeNotification()
        
        withAnimation(.easeInOut(duration: TransitionManager().transitionDuration)) {
            isPiggyBankScene.toggle()
        }
//    completion: {
//            switchHappened = true
//        }
    }
}

#Preview {
    LayersManager(initialView: GamblingTransitionManager())
}
