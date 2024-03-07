//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 24/01/24.
//

import SwiftUI

struct GlobalPositionUtility {
    static func getGlobalPosition(view: GeometryProxy) -> CGPoint? {
        let circleRect = view.frame(in: .global)
        return CGPoint(x: circleRect.midX, y: circleRect.midY)
    }
}
