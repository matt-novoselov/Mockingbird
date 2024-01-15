//
//  Exp2_call_and_link.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct Exp2_call_and_link: View {
    var body: some View {
        
        VStack{
            Link("example.com", destination: URL(string: "https://example.com")!)
                .foregroundStyle(.black)
            
            Link("+1 209 030 20 29", destination: URL(string: "tel://+12090302029")!)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    Exp2_call_and_link()
}
