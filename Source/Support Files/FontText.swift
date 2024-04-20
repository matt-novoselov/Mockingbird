//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 10/01/24.
//

import SwiftUI

// Structure for Text with custom font
struct FontText: View {
    @State private var font: Font?
    var text: String
    var size: CGFloat
    
    var body: some View {
        Text(text)
            .font(font)
            .onAppear(){
                font = getFont(size: size)
            }
    }
}

#Preview {
    FontText(text: "Hello Custom Font!", size: 55)
}
