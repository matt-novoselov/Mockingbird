//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct LastScene: View {
    
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    // Display diagram with animation after transition
    @State var displayingDiagram: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            if displayingDiagram{
                CycleAnimated()
                    .scaleEffect(0.6)
            }
        }
        
        .onAppear(){
            
            // Start animation after transition is complete
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration ) {
                displayingDiagram = true
            }
            
            // Call notification after diagram animation is complete
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration + 4.0) {
                notificationManager.callNotification(ID: 18, arrowAction: {
                    transitionManagerObservable.transitionToScene?(14)
                })
            }
            
        }
        
    }
}

#Preview {
    LayersManager(initialView: LastScene())
}
