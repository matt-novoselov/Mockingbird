//
//  PortraitModeBlockerView.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 29/12/23.
//

import SwiftUI

struct PortraitModeBlockerView: View {
    @State private var orientation = UIInterfaceOrientation.unknown
    
    var body: some View {
        ZStack{
            if orientation.isPortrait {
                BlockerMessage()
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                orientation = windowScene.interfaceOrientation
            }
        }
    }
}

struct BlockerMessage: View {
    var body: some View {
        ZStack{
            Color(.red)
                .ignoresSafeArea()
            
            Text("Experience is better in the landscape mode")
        }
    }
}

#Preview {
    BlockerMessage()
}
