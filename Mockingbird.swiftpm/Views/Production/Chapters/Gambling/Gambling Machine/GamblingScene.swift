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
    
    @State var darkSlider: Double = 0.15
    @State var heavenSlider: Double = 0
    
    @State var isCoinInsertedInMachine: Bool = false
    
    @State var countVisitsToHeaven: Int = 0
    
    @State var isInHeaven: Bool = false

    var body: some View {
        let rectCollider = createMachineCollider(height: 200, width: 200)
        
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            HStack (spacing: 0){
                DynamicMachineCollider(rectCollider: rectCollider)
                    .background(isCoinInsertedInMachine ? Color.yellow : Color.green)
                
                AnimatedHandle(isCoinInserted: $isCoinInsertedInMachine, handleResult: handleResult)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        ForEach(0..<3) { _ in
                            DraggableCoin(isCoinInsertedInMachine: $isCoinInsertedInMachine, isInHeaven: $isInHeaven, insertCoin: insertCoin, rectCollider: rectCollider)
                                .environmentObject(notificationManager)
                        }
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                notificationManager.callNotification(ID: 10)
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
            print("win!")
            
            let tuple = heavenValues[countVisitsToHeaven]
            goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
            countVisitsToHeaven+=1
        }
        else{
            print("loose")
            
            notificationManager.callNotification(ID: 13, arrowAction: {
                transitionManagerObservable.transitionToScene?(8)
            })
        }
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
