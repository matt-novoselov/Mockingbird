//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp14_scaling: View {
    var body: some View {
        VStack{
            ZStack{
                Image("grid")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Image("cubes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Exp14_scaling()
}
