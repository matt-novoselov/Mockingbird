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
    
    @State var darkSlider: Double = 0.4
    @State var heavenSlider: Double = 0
    
    @State var isShaken: Bool = false
    @State var showPill: Bool = false
    
    @State var countPills: Int = 0
    @State var countShakes: Int = 0
    
    @State var showingHint: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            VStack{
                Spacer()
                
                if showPill{
                    DrugsPill(goToHeaven: goToHeaven, showPill: $showPill, count: $countPills)
                        .padding(.bottom, 100)
                }
            }
            
            ZStack{
                Image("drugs_hint")
                    .interpolation(.high)
                    .aspectRatio(contentMode: .fit)
                    .allowsTightening(false)
                    .opacity(showingHint ? 0.2 : 0)
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration + 0.25) {
                            withAnimation(.easeInOut(duration: 1.0)){
                                showingHint = true
                            }
                        }
                    }
                    .onChange(of: notificationManager.isTextPrintFinished){ newValue in
                        if newValue == true && countShakes<3{
                            withAnimation(.easeInOut(duration: 1.0)){
                                showingHint = true
                            }
                        }
                    }
                
                DraggableShakableView(handleShake: handleShake)
            }

        }
    }
    
    func handleShake() {
        if isShaken{
            return
        }
        
        if !notificationManager.isTextPrintFinished{
            return
        }
        
        countShakes += 1
        
        withAnimation(.easeInOut(duration: 1.0)){
            showingHint = false
        }
        
        isShaken = true
        
        if countPills<2{
            countPills += 1
            withAnimation{
                showPill = true
            }
        }
        else{
            notificationManager.callNotification(ID: 15, arrowAction: {
                transitionManagerObservable.transitionToScene?(9)
            }, darkMode: true)
        }
    }
    
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        let animationDuration = 3.0
        
        notificationManager.closeNotification()
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = heavenSliderGoal ?? 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            withAnimation(.easeInOut(duration: 0.5)) {
                darkSlider = darkSliderAfterwards ?? darkSlider
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                isShaken = false
                
                if countPills == 1{
                    notificationManager.callNotification(ID: 13, darkMode: true)
                }
                else if countPills == 2{
                    notificationManager.callNotification(ID: 14, darkMode: true)
                }
            }
        }
    }
}

#Preview {
    LayersManager(initialView: DrugsScene())
}
