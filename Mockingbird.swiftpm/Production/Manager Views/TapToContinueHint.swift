//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 14/02/24.
//

import SwiftUI

struct TapToContinueHint: View {
    @State var lightBlinking: Bool = false
    @Binding var displayingHint: Bool
    
    var darkMode: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            
            FontText(text: "tap to continue", size: 52)
                .foregroundColor(darkMode ? .white : .black).opacity(lightBlinking ? 0.55 : 0.4)
                .opacity(displayingHint ? 1 : 0)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)
                .onAppear {
                    let animationDuration: Double = 0.75
                    
                    Timer.scheduledTimer(withTimeInterval: animationDuration * 2, repeats: true) { timer in
                        withAnimation(Animation.easeInOut(duration: animationDuration)) {
                            lightBlinking.toggle()
                        }
                    }
                }

        }
    }
}

#Preview {
    TapToContinueHint(displayingHint: .constant(true), darkMode: false)
}
