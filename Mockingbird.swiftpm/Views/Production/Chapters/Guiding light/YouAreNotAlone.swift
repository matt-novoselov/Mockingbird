//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct YouAreNotAlone: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    var body: some View {
        Text("You are not alone")
    }
}

#Preview {
    YouAreNotAlone()
}
