//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

// This is a View responsible for mixing different layers in the game
struct LayersManager: View {
    
    // Base ground View
    let initialView: any View

    var body: some View {
        ZStack {
            AnyView(initialView)
            
            // Particles Layer
            SwiftuiParticles()
            
            // Notifications Layer
            NotificationManagerView()
        }
        .environmentObject(NotificationManager())
        .environmentObject(TransitionManagerObservable())
        .statusBar(hidden: true)
    }
}


#Preview {
    LayersManager(initialView: TransitionManager())
}
