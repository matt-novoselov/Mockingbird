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
    
    @State var shouldShowArrowAgain: Bool = true
    
    @State var lightsBlinking: Bool = true
    
    @State var showingBlinkingLights: Bool = false
    
    @State var firstMessageWasDisplayed: Bool = false
    
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
                    .frame(width: 200)
                    .padding()
                    .opacity(0)
                
                ZStack{
                    AnimatedHandle(isCoinInserted: $isCoinInsertedInMachine, handleResult: handleResult, handleNoCoin: handleNoCoin)
                        .frame(height: 100)
                        .offset(x: 160, y: -45)
                    
                    Image("gambling_base")
                        .interpolation(.high)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(
                            SlotsRotation(changeBool: $changeBool)
                                .offset(y: 10)
                                .frame(width: 170)
                                .mask(
                                    Rectangle()
                                        .frame(height: 60)
                                        .offset(y: 15)
                                )
                        )
                        .overlay(){
                            Image("gambling_overlay")
                                .interpolation(.high)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .allowsHitTesting(false)
                    
                    
                    ZStack{
                        if showingBlinkingLights{
                            ZStack{
                                Image("gambling_lights_1")
                                    .interpolation(.high)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .glow(color: Color("MainYellow").opacity(0.4), radius: 10)
                                    .opacity(lightsBlinking ? 1 : 0)
                                
                                Image("gambling_lights_2")
                                    .interpolation(.high)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .glow(color: Color("MainYellow").opacity(0.4), radius: 10)
                                    .opacity(lightsBlinking ? 0 : 1)
                            }
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
                                    lightsBlinking.toggle()
                                }
                            }
                        }
                    }
                    .opacity(showingBlinkingLights ? 1 : 0)
                    .allowsHitTesting(false)
                }
                .frame(height: 350)
                
                
                Image("arrow_white")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding()
                    .opacity(showingCoins ? 1 : 0)
                    .opacity(shouldShowArrowAgain ? 1 : 0)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    if showingCoins{
                        VStack {
                            ForEach(0..<amountOfCoinsOnStart, id: \.self) { index in
                                DraggableCoin(isCoinInsertedInMachine: $isCoinInsertedInMachine, isInHeaven: $isInHeaven, insertCoin: insertCoin, centerOfScreen: centerOfTheScreen, selectedStyle: index)
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
            
            withAnimation(.easeInOut) {
                shouldShowArrowAgain = false
            }
            
            withAnimation(){
                showingBlinkingLights = false
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
            isInHeaven = true
            changeBool.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + SlotsRotation(changeBool: .constant(false)).animationDuration) {
                
                ParticleView.spawnParticle(xpos: Double(centerOfTheScreen.x), ypos: Double(centerOfTheScreen.y))
                
                withAnimation(){
                    showingBlinkingLights = true
                }
                
                let tuple = heavenValues[countVisitsToHeaven]
                goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
                countVisitsToHeaven+=1
                
            }
        }
        else{
            // case loose
            
            changeBool.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + SlotsRotation(changeBool: .constant(false)).animationDuration) {
                notificationManager.callNotification(ID: 12, arrowAction: {
                    transitionManagerObservable.transitionToScene?(8)
                })
            }
        }
    }
    
    func handleNoCoin(){
        if notificationManager.isTextDisplayed == false && countVisitsToHeaven == 0 && !firstMessageWasDisplayed{
            firstMessageWasDisplayed = true
            notificationManager.callNotification(ID: 10)
        }
    }
    
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        let animationDuration = 2.5
        
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
                
                if countVisitsToHeaven == 1{
                    notificationManager.callNotification(ID: 11)
                }
            }
        }
    }
}

#Preview{
    LayersManager(initialView: GamblingScene())
}
