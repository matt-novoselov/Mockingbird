//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct BetterExperienceInHeadphones: View {
    var body: some View {
        Text("Better experience with headphones")
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    print("Transitioning to the next scene...")
                }
            }
    }
}

#Preview {
    BetterExperienceInHeadphones()
}
