//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 10/01/24.
//

import SwiftUI

struct FontText: View {
    @State private var font: Font?
    var text: String
    
    var body: some View {
        Text(text)
            .font(font)
            .onAppear(){
                font = getFont()
            }
    }
}

#Preview {
    FontText(text: "Hello Custom Font!")
}
