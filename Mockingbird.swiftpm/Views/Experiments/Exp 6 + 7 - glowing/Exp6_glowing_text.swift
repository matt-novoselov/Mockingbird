//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 16/01/24.
//

import SwiftUI

struct Exp6_glowing_text: View {
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            
            VStack{
                Text("guiding light")
                    .foregroundColor(.yellow)
                    .shadow(color: .yellow, radius: 10)
                
                Text("guiding light")
                    .foregroundColor(.yellow)
                    .glow(color: .yellow.opacity(0.4), radius: 10)
                
                ZStack{
                    Group {
                        Text("Even in the darkest time you can find the the the the the the ")
                            .foregroundColor(.white) +
                        
                        Text("guiding light")
                            .foregroundColor(.yellow)
                    }
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                    Text("Even in the darkest time you can find the the the the the the guiding light")
                        .foregroundColor(.yellow)
                        .glow(color: .yellow.opacity(0.4), radius: 10)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                }
                

            }
            
        }
    }
}

#Preview {
    Exp6_glowing_text()
}
