//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct NotificationTextBlob: View {
    var text: String = ""
    
    @State var shift: Int = 0
    let animationMoveInDuration: Double = 1.0
    
    var body: some View {
        Group {
            Text(String(text.prefix(shift)))
                .font(getFont(size: 32))
                .foregroundColor(.black) +
            
            Text(String(text.suffix(from: text.index(text.startIndex, offsetBy: shift))))
                .font(getFont(size: 32))
                .foregroundColor(.black.opacity(0))
            
        }
        .frame(maxWidth: 330)
        .padding()
        .background(Color.gray)
        .clipShape(BubbleShape())
        .padding()
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + animationMoveInDuration - 0.25) {
                typeWriter()
            }
        }
        .transition(.move(edge: .leading))
    }
    
    func typeWriter() {
        if shift < text.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                shift+=1
                typeWriter()
            }
        }
    }
}

#Preview {
    NotificationTextBlob(text: "Ex est aliquip sunt excepteur id reprehenderit velit enim sunt eu ullamco duis duis elit duis amet aute.")
}
