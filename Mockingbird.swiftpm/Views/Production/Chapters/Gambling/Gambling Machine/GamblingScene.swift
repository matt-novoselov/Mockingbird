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
    
    @State var centerOfTheScreen: CGPoint?
    
    var amountOfCoinsOnStart: Int = 3
    
    @State var showingCoins: Bool = false
    
//    var switchScene: () -> Void
    
    @State var hasStartedSwitchingToScene: Bool = false
    
    var body: some View {
        let rectCollider = createMachineCollider(height: 200, width: 200)
        
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
                DynamicMachineCollider(rectCollider: rectCollider)
                    .background(isCoinInsertedInMachine ? Color.yellow : Color.green)
                
                AnimatedHandle(isCoinInserted: $isCoinInsertedInMachine, handleResult: handleResult, handleNoCoin: handleNoCoin)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    if showingCoins{
                        VStack {
                            ForEach(0..<amountOfCoinsOnStart, id: \.self) { _ in
                                DraggableCoin(isCoinInsertedInMachine: $isCoinInsertedInMachine, isInHeaven: $isInHeaven, insertCoin: insertCoin, rectCollider: rectCollider)
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
                    withAnimation(Animation.easeInOut(duration: 1.5)){
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
            (0.85, 0.35),
            (0.85, 0.5),
        ]
        
        if countVisitsToHeaven<2{
            // case win
            
            ParticleView.spawnParticle(xpos: Double(centerOfTheScreen?.x ?? 0), ypos: Double(centerOfTheScreen?.y ?? 0))
            
            let tuple = heavenValues[countVisitsToHeaven]
            goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
            countVisitsToHeaven+=1
        }
        else{
            // case loose
            
            notificationManager.callNotification(ID: 13, arrowAction: {
                transitionManagerObservable.transitionToScene?(8)
            })
        }
    }
    
    func handleNoCoin(){
        if notificationManager.isTextDisplayed == false && countVisitsToHeaven == 0{
            //print("no coin, first try")
            notificationManager.callNotification(ID: 10)
        }
        
//        if notificationManager.isTextDisplayed == true && countVisitsToHeaven == 2 && notificationManager.isTextPrintFinished && !hasStartedSwitchingToScene{
//            //print("no coin, switching scenes")
//            hasStartedSwitchingToScene = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                switchScene()
//            }
//        }
    }
    
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        isInHeaven = true
        let animationDuration = 3.0
        
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
                else if countVisitsToHeaven == 2{
                    notificationManager.callNotification(ID: 12)
                }
            }
        }
    }
}

#Preview{
    LayersManager(initialView: GamblingScene())
}
