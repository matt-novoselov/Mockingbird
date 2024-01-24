//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct InstagramScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            InstagramViewController()
                .padding(.all, 100)
                .environmentObject(transitionManagerObservable)
        }
    }
}

#Preview {
    LayersManager(initialView: InstagramScene())
}
