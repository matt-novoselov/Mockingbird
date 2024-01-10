//
//  OrientationModel.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 29/12/23.
//

import SwiftUI


// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIInterfaceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didChangeStatusBarOrientationNotification)) { _ in
                action(UIApplication.shared.statusBarOrientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIInterfaceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
