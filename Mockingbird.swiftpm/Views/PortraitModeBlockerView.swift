//
//  PortraitModeBlockerView.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 29/12/23.
//

import SwiftUI

struct PortraitModeBlockerView: View {
    var body: some View {
        ZStack{
            Color(.red)
                .ignoresSafeArea()
            
            Text("Please, rotate the screen to the landscape")
        }
    }
}

#Preview {
    PortraitModeBlockerView()
}
