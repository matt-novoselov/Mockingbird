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
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            Text("Rather than relying on substances or temporary escapes, try to find happiness in the present moment.")
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                notificationManager.callNotification(ID: 20, arrowAction: {
                    transitionManagerObservable.transitionToScene?(14)
                })
            }
        }
    }
}

#Preview {
    LayersManager(initialView: LastScene())
}
