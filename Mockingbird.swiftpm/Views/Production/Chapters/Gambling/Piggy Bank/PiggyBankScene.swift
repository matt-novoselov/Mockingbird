//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct PiggyBankScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        Text("PiggyBankScene")
    }
}

#Preview {
    PiggyBankScene()
}
