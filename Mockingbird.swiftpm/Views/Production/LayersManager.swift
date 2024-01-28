//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct LayersManager<InitialView: View>: View {
    let initialView: InitialView

    init(initialView: InitialView) {
        self.initialView = initialView
    }

    var body: some View {
        ZStack {
            initialView
            
            SwiftuiParticles()
            
            NotificationManagerView()
            
//            PortraitModeBlockerView()
        }
        .environmentObject(NotificationManager())
        .environmentObject(TransitionManagerObservable())
    }
}


#Preview {
    LayersManager(initialView: TransitionManager())
}
