//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}
