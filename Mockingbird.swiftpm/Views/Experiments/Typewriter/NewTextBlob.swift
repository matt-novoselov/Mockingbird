//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct NewTextBlob: View {
    @State var shift: Int = 0
    var finalText: String = ""
    let animationMoveInDuration: Double = 1.0
    
    var body: some View {
        Group {
            Text(String(finalText.prefix(shift)))
                .font(getFont(size: 32))
                .foregroundColor(.black) +
            
            Text(String(finalText.suffix(from: finalText.index(finalText.startIndex, offsetBy: shift))))
                .font(getFont(size: 32))
                .foregroundColor(.black.opacity(0))

        }
        .frame(maxWidth: 330)
        .padding()
        .background(.gray)
        .cornerRadius(20)
        .padding()
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + animationMoveInDuration - 0.25) {
                typeWriter()
            }
        }
        .transition(.move(edge: .leading))
    }
    
    func typeWriter() {
        if shift < finalText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                shift+=1
                typeWriter()
            }
        }
    }
}

#Preview {
    NewTextBlob(finalText: "Ex est aliquip sunt excepteur id reprehenderit velit enim sunt eu ullamco duis duis elit duis amet aute.")
}
