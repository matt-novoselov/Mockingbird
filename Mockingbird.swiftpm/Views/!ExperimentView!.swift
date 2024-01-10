//
//  FontModel.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 27/12/23.
//

import SwiftUI

struct ExperimentView: View {
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .fill(Color.MBgreenColor)
                    .frame(width: 200, height: 200)
                
                Image("Image1")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                FontText(text: "Hello world!")
            }
        }
    }
}

#Preview {
    ExperimentView()
}
