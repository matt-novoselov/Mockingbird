//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct YouAreNotAlone: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        Text("You are not alone")
    }
}

#Preview {
    YouAreNotAlone(transitionToScene: TransitionManager().transitionToScene)
}
