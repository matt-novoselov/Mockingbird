//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 16/01/24.
//

import SwiftUI

struct Exp4_image_button: View {
    @State var currentDisplayedImage: String = "grid"
    
    var body: some View {
        Button(action: {
            withAnimation(.none) {
                currentDisplayedImage = "calendar"
            }
        })
        {
            Image(currentDisplayedImage)
        }
    }
}

#Preview {
    Exp4_image_button()
}
