//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 16/01/24.
//

import SwiftUI

struct Exp4_image_button: View {
    @State var currentDisplayedImage: String = "PH_grid"
    
    var body: some View {
        Button(action: {
            withAnimation(.none) {
                currentDisplayedImage = "PH_calendar"
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
