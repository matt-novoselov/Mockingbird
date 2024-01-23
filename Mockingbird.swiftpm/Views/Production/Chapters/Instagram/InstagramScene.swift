//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct InstagramScene: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        InstagramViewController()
            .padding(.all, 100)
    }
}

#Preview {
    InstagramScene(transitionToScene: TransitionManager().transitionToScene)
}
