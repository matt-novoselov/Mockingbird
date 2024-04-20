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
    
    // Property that controls value of dark background
    @State var darkSlider: Double = 0.4
    
    // Property that controls value of heaven background
    @State var heavenSlider: Double = 0
    
    // Control if drug box was shaken
    @State var isShaken: Bool = false
    
    // Value that controls if pill is being shown
    @State var showingPill: Bool = false
    
    // Count an amount of eaten pills
    @State var countPills: Int = 0
    
    // Count an amount of box shakes
    @State var countShakes: Int = 0
    
    // Shwoing hint to help users understand the action
    @State var showingHint: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            VStack{
                Spacer()
                
                if showingPill{
                    DrugsPill(goToHeaven: goToHeaven, showPill: $showingPill, count: $countPills)
                        .padding(.bottom, 100)
                }
            }
            
            ZStack{
                Image("drugs_hint")
                    .interpolation(.high)
                    .aspectRatio(contentMode: .fit)
                    .allowsTightening(false)
                    .opacity(showingHint ? 0.2 : 0)
                
                    // Display hint
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration + 0.25) {
                            if !showingPill{
                                withAnimation(.easeInOut(duration: 1.0)){
                                    showingHint = true
                                }
                            }
                        }
                    }
                    .onChange(of: notificationManager.isTextPrintFinished){
                        if notificationManager.isTextPrintFinished == true && countShakes<3{
                            withAnimation(.easeInOut(duration: 1.0)){
                                showingHint = true
                            }
                        }
                    }
                
                // Drug box interactable view
                DraggableShakableView(handleShake: handleShake)
            }

        }
    }
    
    // Acrion that happens after box was shaken
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
                showingPill = true
            }
        }
        else{
            notificationManager.callNotification(ID: 15, arrowAction: {
                transitionManagerObservable.transitionToScene?(9)
            }, darkMode: true)
        }
    }
    
    // Animation for going to heaven
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        
        // Adjust animation duration
        let animationDuration = 3.0
        
        // Play sound effect
        playSound(name: "heaven_drugs", ext: "mp3")
        
        // Close notifiaction
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
