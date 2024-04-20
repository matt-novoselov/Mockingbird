//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 24/01/24.
//

import SwiftUI

// Function that translates form local coordinates to the global space
struct GlobalPositionUtility {
    static func getGlobalPosition(view: GeometryProxy) -> CGPoint? {
        let viewFrame = view.frame(in: .global)
        return CGPoint(x: viewFrame.midX, y: viewFrame.midY)
    }
}
