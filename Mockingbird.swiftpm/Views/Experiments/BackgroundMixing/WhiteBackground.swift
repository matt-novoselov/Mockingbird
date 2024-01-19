//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct WhiteBackground: View {    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
        }
        .ignoresSafeArea()
    }
}
