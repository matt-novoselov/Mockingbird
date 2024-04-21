//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 14/02/24.
//

import SwiftUI

// Hint that appears to help users
struct TapToContinueHint: View {
    
    // Current opacity of the text
    @State private var opacity: Double = 0.4
    
    // Bool that controls if the Hint is currently displayed or not
    @Binding var displayingHint: Bool
    
    // Apply different style for dark and light modes
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
                    withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                        self.opacity = 0.55
                    }
                }

        }
    }
}

#Preview {
    TapToContinueHint(displayingHint: .constant(true), darkMode: false)
}
