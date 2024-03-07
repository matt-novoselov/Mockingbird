//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp18_dynamic_resize: View {
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.6)
                
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: geometry.size.width * 0.05, height: geometry.size.height * 0.4)
                    .offset(x: geometry.size.width * 0.225)
            }
        }
        .aspectRatio(1.0, contentMode: .fit)

    }
}

#Preview {
    Exp18_dynamic_resize()
}
