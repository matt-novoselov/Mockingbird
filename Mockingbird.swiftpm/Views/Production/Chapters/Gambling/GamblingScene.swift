//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct GamblingScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State public var darkSlider: Double = 0.15
    @State var heavenSlider: Double = 0
    
    @State var isCoinInsertedInMachine: Bool = false
    
    @State var countVisitsToHeaven: Int = 0
    
    @State var isInHeaven: Bool = false
    
    @State var centerOfTheScreen: CGPoint = CGPoint(x: 0, y: 0)
    
    var amountOfCoinsOnStart: Int = 2
    
    @State var showingCoins: Bool = false
    
    @State var hasStartedSwitchingToScene: Bool = false
    
    @State var changeBool: Bool = false
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        if let centerOfScreen = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                            centerOfTheScreen = centerOfScreen
                        }
                    }
            }
            
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            HStack (spacing: 0){
                Image("arrow_white")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding()
                    .opacity(0)
                
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(isCoinInsertedInMachine ? Color.yellow : Color.green)
                    .overlay(
                        SlotsRotation(changeBool: $changeBool)
                            .frame(width: 300, height: 100)
                            .mask(
                                Rectangle()
                                    .frame(width: 300, height: 100)
                            )
                            .scaleEffect(0.6)
                    )
                
                AnimatedHandle(isCoinInserted: $isCoinInsertedInMachine, handleResult: handleResult, handleNoCoin: handleNoCoin)
                
                Image("arrow_white")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding()
                    .opacity(showingCoins ? 1 : 0)
                    .opacity(countVisitsToHeaven == 0 ? 1 : 0)
                    .opacity(isCoinInsertedInMachine == true ? 0 : 1)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    if showingCoins{
                        VStack {
                            ForEach(0..<amountOfCoinsOnStart, id: \.self) { _ in
                                DraggableCoin(isCoinInsertedInMachine: $isCoinInsertedInMachine, isInHeaven: $isInHeaven, insertCoin: insertCoin, centerOfScreen: centerOfTheScreen)
                                    .environmentObject(notificationManager)
                            }
                        }
                        .padding()
                        .transition(.move(edge: .trailing))
                    }
                    
                }
                Spacer()
            }
            .onChange(of: notificationManager.isTextPrintFinished){
                if (notificationManager.isTextPrintFinished == true && countVisitsToHeaven==0){
                    withAnimation(Animation.easeInOut(duration: 1.0)){
                        showingCoins = true
                    }
                }
            }

        }
    }
    
    func insertCoin() {
        if !isCoinInsertedInMachine{
            withAnimation(.easeInOut) {
                isCoinInsertedInMachine = true
            }
            
            notificationManager.closeNotification()
        }
    }
    
    func handleResult(){
        let heavenValues: [(Double, Double)] = [
            (0.85, 0.4),
            (0.85, 0.5),
        ]
        
        if countVisitsToHeaven<1{
            // case win
            changeBool = true
            
            ParticleView.spawnParticle(xpos: Double(centerOfTheScreen.x), ypos: Double(centerOfTheScreen.y))
            
            let tuple = heavenValues[countVisitsToHeaven]
            goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
            countVisitsToHeaven+=1
        }
        else{
            // case loose
            
            notificationManager.callNotification(ID: 12, arrowAction: {
                transitionManagerObservable.transitionToScene?(8)
            })
        }
    }
    
    func handleNoCoin(){
        if notificationManager.isTextDisplayed == false && countVisitsToHeaven == 0{
            //print("no coin, first try")
            notificationManager.callNotification(ID: 10)
        }
    }
    
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        isInHeaven = true
        let animationDuration = 1.5
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = heavenSliderGoal ?? 1.0
        } completion: {
            withAnimation(.easeInOut(duration: 0.5)) {
                darkSlider = darkSliderAfterwards ?? darkSlider
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            } completion: {
                // handle end of visit to heaven
                
                isInHeaven = false
            }
            
            if countVisitsToHeaven == 1{
                notificationManager.callNotification(ID: 11)
            }
//            else if countVisitsToHeaven == 2{
//                notificationManager.callNotification(ID: 12)
//            }
        }
    }
}

#Preview{
    LayersManager(initialView: GamblingScene())
}
