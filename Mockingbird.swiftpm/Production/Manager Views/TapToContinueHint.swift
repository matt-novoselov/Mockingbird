//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 14/02/24.
//

import SwiftUI

struct TapToContinueHint: View {
    @State private var opacity: Double = 0.4
    @Binding var displayingHint: Bool
    
    var darkMode: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            
            FontText(text: "tap to continue", size: 52)
                .foregroundColor(darkMode ? .white : .black).opacity(opacity)
                .opacity(displayingHint ? 1 : 0)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                        self.opacity = 0.55
                    }
                }

        }
    }
}

#Preview {
    TapToContinueHint(displayingHint: .constant(true), darkMode: false)
}
