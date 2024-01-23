//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct PiggyBankScene: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        Text("PiggyBankScene")
    }
}

#Preview {
    PiggyBankScene(transitionToScene: TransitionManager().transitionToScene)
}
