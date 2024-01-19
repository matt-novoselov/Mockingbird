//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI

struct Exp12_left_up_corner: View {
    @State var text: String = ""
    let finalText: String = "Sint commodo laborum magna fugiat culpa amet minim cillum fugiat. Reprehenderit quis sit excepteur nisi labore quis aute."
    
    var body: some View {
        VStack{
            HStack{
                Text(text)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 200)
                    .padding()
                    .background(.gray)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .padding()
                    .onAppear(){
                        typeWriter()
                    }

                Spacer()
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func typeWriter(at position: Int = 0) {
        if position == 0 {
            text = ""
        }
        if position < finalText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                text.append(finalText[position])
                typeWriter(at: position + 1)
            }
        }
    }
}

#Preview {
    Exp12_left_up_corner()
}
