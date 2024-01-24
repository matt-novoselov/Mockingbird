//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct DrugsScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    @State var darkSlider: Double = 0.5
    @State var heavenSlider: Double = 0
    
    @State var isShaken: Bool = false
    @State var showPill: Bool = false
    
    @State var countPills: Int = 0
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            DraggableShakableView(handleShake: handleShake)
                .glow(color: Color("MB_main_yellow").opacity((1 - heavenSlider)/2), radius: 100)
            
            VStack{
                Spacer()
                
                if showPill{
                    DrugsPill(goToHeaven: goToHeaven, showPill: $showPill, count: $countPills)
                }
            }
        }
    }
    
    func handleShake() {
        if isShaken{
            return
        }
        
        isShaken = true
        
        if countPills<3{
            countPills += 1
            withAnimation{
                showPill = true
            }
        }
        else{
            notificationManager.callNotification(ID: 0, darkMode: true)
        }
    }
    
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        let animationDuration = 5.0
        notificationManager.closeNotification()
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = heavenSliderGoal ?? 1.0
        } completion: {
            withAnimation(.none) {
                darkSlider = darkSliderAfterwards ?? darkSlider
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            } completion: {
                isShaken = false
                
                if countPills == 1{
                    notificationManager.callNotification(ID: 0, darkMode: true)
                }
                else if countPills == 2{
                    notificationManager.callNotification(ID: 1, darkMode: true)
                }
            }
        }
    }
}

struct DrugsPill: View {
    var goToHeaven: (Double, Double) -> Void
    @Binding var showPill: Bool
    @Binding var count: Int
    
    
    let heavenValues: [(Double, Double)] = [
        (1.0, 0.8),
        (1.0, 1.0),
        (0.25, 1.0),
    ]
    
    var body: some View {
        Button(action: {
            let tuple = heavenValues[count - 1]
            goToHeaven(tuple.0, tuple.1)
            
            showPill = false
        }){
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color("MB_main_yellow"))
                .padding()
        }
        .buttonStyle(NoOpacityButtonStyle())
        .transition(
            .asymmetric(insertion: .move(edge: .top), removal: .opacity)
        )
    }
}

#Preview {
    LayersManager(initialView: DrugsScene())
}
