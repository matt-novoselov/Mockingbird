//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct Exp12_left_up_corner: View {
    var body: some View {
        VStack{
            HStack{
                Text("Laborum excepteur excepteur aliquip sint mollit nulla aliquip nulla duis.")
                    .font(.title3)
                    .frame(maxWidth: 200)
//                    .background(.red)
                    .padding()
                    .background(.gray)
//                    .stroke(.black, lineWidth: 20)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .padding()

                
                Spacer()
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Exp12_left_up_corner()
}
