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
    
    var body: some View {
        Group {
            Text(String(finalText.prefix(shift)))
                .foregroundColor(.black) +
            
            Text(String(finalText.suffix(from: finalText.index(finalText.startIndex, offsetBy: shift))))
                .foregroundColor(.black.opacity(0))
                
        }
        .font(.title3)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: 200)
        .padding()
        .background(.gray)
        .cornerRadius(15)
        .padding()
        .onAppear(){
            typeWriter()
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
