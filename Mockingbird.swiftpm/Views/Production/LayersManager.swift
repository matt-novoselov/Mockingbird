//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct LayersManager: View {
    var body: some View {
        ZStack{
            TransitionManager()
            
            SwiftuiParticles()
            
            NotificationManagerView()
            
            PortraitModeBlockerView()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LayersManager()
}
