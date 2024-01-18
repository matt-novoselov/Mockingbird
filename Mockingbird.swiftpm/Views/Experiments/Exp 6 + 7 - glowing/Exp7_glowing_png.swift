//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 16/01/24.
//

import SwiftUI

struct SwiftUIView: View {
    @State var isShowingShadow: Bool = false
    
    var body: some View {
        Button(action: {
            isShowingShadow.toggle()
        })
        {
            
            Image("cubes")
                .shadow(color: .red.opacity(isShowingShadow ? 1.0 : 0.0), radius: 20)
            
        }
        .buttonStyle(PlainButtonStyle())
        
        Button(action: {
            isShowingShadow.toggle()
        })
        {
            
            Image("cubes")
                .glow(color: .red.opacity(isShowingShadow ? 0.4 : 0.0), radius: 20)
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SwiftUIView()
}