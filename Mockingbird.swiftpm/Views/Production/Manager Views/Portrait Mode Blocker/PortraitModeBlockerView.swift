//
//  PortraitModeBlockerView.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 29/12/23.
//

import SwiftUI

// Transparent by default
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


#Preview {
    PortraitModeBlockerView()
}
