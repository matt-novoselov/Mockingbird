//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 22/01/24.
//

import SwiftUI

struct Exp23_ArrangeProblem: View {
    @State var screenWidth: CGFloat?
    @State var screenHeight: CGFloat?
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
                    .onAppear(){
                        screenWidth = geometry.size.width
                        screenHeight = geometry.size.height
                    }
            }
            
            VStack {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .padding()
                
                Spacer()
            }
            .frame(maxWidth: screenWidth,
                   maxHeight: screenHeight)
        }
    }
}

#Preview {
    Exp23_ArrangeProblem()
}
