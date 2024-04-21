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
    
    // Count total amount of times the different drinks were drank
    @State var countDrinks: Int = 0
    
    // Property that controls value of heaven background
    @State var heavenSlider: Double = 0
    
    // Control the ID of the currently displayed drink
    @State var currentDrinkID: Int = 0
    
    // Prevent accidental interaction with the scene before transition animation is done
    @State var canInteractAfterInitialOpening: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: $heavenSlider)
            
            VStack{
                Group{
                    // Display drink according to its ID
                    switch currentDrinkID {
                    case 0:
                        AlcoholDrink(selectedStyle: 2, countBites: $countDrinks, heavenSlider: $heavenSlider, canInteractAfterInitialOpening: $canInteractAfterInitialOpening, currentDrinkID: $currentDrinkID)
                    case 1:
                        AlcoholDrink(selectedStyle: 1, countBites: $countDrinks, heavenSlider: $heavenSlider, canInteractAfterInitialOpening: $canInteractAfterInitialOpening, currentDrinkID: $currentDrinkID)
                    case 2:
                        AlcoholDrink(selectedStyle: 0, countBites: $countDrinks, heavenSlider: $heavenSlider, canInteractAfterInitialOpening: $canInteractAfterInitialOpening, currentDrinkID: $currentDrinkID)
                            
                    default:
                        Text("Error, this drink ID doesn't exist")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 100)
                .transition(.pushRightTransition)
            }
            .environmentObject(notificationManager)
            .environmentObject(transitionManagerObservable)
            
            // Prevent accidental interaction with the scene before transition animation is done
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                    notificationManager.callNotification(ID: 3)
                    canInteractAfterInitialOpening = true
                }
            }
            
        }
    }
}

#Preview {
    LayersManager(initialView: AlcoholScene())
}
