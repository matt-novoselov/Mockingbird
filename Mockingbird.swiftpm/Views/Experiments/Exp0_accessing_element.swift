//
//  FontModel.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 27/12/23.
//

import SwiftUI

struct Exp0_accessing_element: View {
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .fill(Color("banana"))
                    .frame(width: 200, height: 200)
                
                Image("grid")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                FontText(text: "Hello world!", size: 35)
            }
        }
    }
}

#Preview {
    Exp0_accessing_element()
}
