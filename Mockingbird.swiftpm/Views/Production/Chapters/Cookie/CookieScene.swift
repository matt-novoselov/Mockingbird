//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct CookieScene: View {
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
    CookieScene()
}
