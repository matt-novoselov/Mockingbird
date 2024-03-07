//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 04/02/24.
//

import SwiftUI

struct AlcoholDrink: View {
    let alcoholArray: [String] = ["wine_bottle","little_glass","wine_glass"]
    
    var selectedStyle: Int = 0
    
    @Binding var countBites: Int
    @Binding var heavenSlider: Double
    @Binding var canInteractAfterInitOpenening: Bool
    @State var isDrinken: Bool = false
    
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    @State var buttonPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    @State var geomtryHolder: GeometryProxy?
    
    @Binding var currentDrinkID: Int
    
    @State var currentState: Int = 1
    
    var body: some View {
        Button(action: {
            if !canInteractAfterInitOpenening{
                return
            }
            
            if !notificationManager.isTextPrintFinished{
                return
            }
            
            if isDrinken{
                return
            }
            
            if let geometryHolder = geomtryHolder,
               let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometryHolder) {
                ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
            }
            
            playSound(name: "Drink_\(selectedStyle+1)", ext: "mp3")
            playSound(name: "heaven_drink", ext: "mp3")
            
            isDrinken = true
            
            withAnimation(.easeInOut) {
                currentState = 0
            }
            
            if countBites != 2{
                notificationManager.callNotification(
                    ID: countBites + 4
                )
            }
            else{
                notificationManager.callNotification(
                    ID: countBites + 4,
                    arrowAction: {
                        transitionManagerObservable.transitionToScene?(5)
                    }
                )
            }
            
            
            countBites+=1
            
            let animationDuration = 2.0
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0.65
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    heavenSlider = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    transitionToNextPost()
                }
            }
            
        })
        {
            ZStack{
                if selectedStyle==0{
                    Image("wine_bottle_underlaying")
                        .interpolation(.high)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                ZStack{
                    if !isDrinken{
                        Image("\(alcoholArray[selectedStyle])_liquid_full")
                            .interpolation(.high)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    else{
                        Image("\(alcoholArray[selectedStyle])_liquid_empty")
                            .interpolation(.high)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .glow(color: Color("MainYellow").opacity(0.4), radius: 50)
                
                Image("\(alcoholArray[selectedStyle])")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(
                        GeometryReader{ geometry in
                            Color.clear
                                .onAppear(){
                                    geomtryHolder = geometry
                                }
                        }
                    )

            }
        }
        .buttonStyle(NoOpacityButtonStyle())
        .padding(.top, selectedStyle == 1 ? 200 : 0)
        .padding(.top, selectedStyle == 2 ? 50 : 0)
    }
    
    func transitionToNextPost() {
        withAnimation(.easeInOut(duration: 1)) {
            if currentDrinkID<2{
                currentDrinkID += 1
            }
        }
    }
}
