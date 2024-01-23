//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct LastScene: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        Text("Rather than relying on substances or temporary escapes, try to find happiness in the present moment.")
    }
}

#Preview {
    LastScene(transitionToScene: TransitionManager().transitionToScene)
}
