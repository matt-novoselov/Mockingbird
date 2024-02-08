//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct AlcoholScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var countBites: Int = 0
    @State var heavenSlider: Double = 0
    
    @State var currentDrinkID: Int = 0
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            VStack{
                Group{
                    switch currentDrinkID {
                    case 0:
                        ZStack{
                            AlcoholDrink(selectedStyle: 2, countBites: $countBites, heavenSlider: $heavenSlider, currentDrinkID: $currentDrinkID)
                        }
                    case 1:
                        ZStack{
                            AlcoholDrink(selectedStyle: 1, countBites: $countBites, heavenSlider: $heavenSlider, currentDrinkID: $currentDrinkID)
                        }
                    case 2:
                        AlcoholDrink(selectedStyle: 0, countBites: $countBites, heavenSlider: $heavenSlider, currentDrinkID: $currentDrinkID)
                            
                    default:
                        Text("Error, this sceneID doesn't exist")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 100)
                .transition(.pushRightTransition)
            }
            .environmentObject(notificationManager)
            .environmentObject(transitionManagerObservable)
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                    notificationManager.callNotification(ID: 3)
                }
            }
            
        }
    }
}

#Preview {
    LayersManager(initialView: AlcoholScene())
}
