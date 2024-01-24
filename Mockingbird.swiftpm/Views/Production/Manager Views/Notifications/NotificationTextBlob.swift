//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct NotificationTextBlob: View {
    var text: String = ""
    var showingArrow: Bool = false
    var showingTail: Bool = false
    var darkMode: Bool = false
    var arrowAction: (() -> Void)?
    
    @State var shift: Int = 0
    @State var customShift: Int = 1
    @State var stateShowButton: Bool = false
    let animationMoveInDuration: Double = 1.0
    
    var body: some View {
        ZStack (alignment: .top){
            Text(String(text.prefix(customShift)))
                .font(getFont(size: 32))
                .foregroundColor(.red.opacity(0))
                .frame(maxWidth: 330)
                .padding()
                .background(
                    BubbleShape(showingTrail: showingTail)
                        .foregroundColor(darkMode ? Color("BlobDarkBackground") : .white)
                )
                .overlay(
                    BubbleShape(showingTrail: showingTail)
                        .stroke(darkMode ? .white : .black, lineWidth: 3)
                )
                .onChange(of: shift){
                    withAnimation{
                        customShift = shift + 10
                    }
                }
            
            Group {
                Text(String(text.prefix(shift)))
                    .font(getFont(size: 32))
                    .foregroundColor(darkMode ? .white : .black) +
                
                Text(String(text.suffix(from: text.index(text.startIndex, offsetBy: shift))))
                    .font(getFont(size: 32))
                    .foregroundColor(.red.opacity(0))
                
            }
            .frame(maxWidth: 330)
            .padding()
            .clipShape(BubbleShape(showingTrail: showingTail))
            
            ZStack (alignment: .bottomTrailing){
                Text(text)
                    .font(getFont(size: 32))
                    .foregroundColor(.red.opacity(0))
                    .frame(maxWidth: 330)
                    .padding()
                
                if showingArrow{
                    ArrowCircleButton(darkMode: darkMode, arrowAction: arrowAction ?? nil)
                        .offset(x: 20, y: 20)
                        .scaleEffect(stateShowButton ? 1.0 : 0.0)
                }
            }
            
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + animationMoveInDuration - 0.25) {
                typeWriter()
            }
        }
        .transition(.move(edge: .leading))
        .ignoresSafeArea()
    }
    
    func typeWriter() {
        if shift < text.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                shift+=1
                typeWriter()
            }
        }
        else{
            // On typewriter animation end
            if showingArrow{
                withAnimation{
                    stateShowButton = true
                }
            }
        }
    }
}

struct ArrowCircleButton: View {
    var darkMode: Bool = false
    var arrowAction: (() -> Void)?
    
    var body: some View {
        Button(
            action: {
                
                arrowAction?()
            }
        ){
            ZStack{
                Circle()
                    .frame(width: 65, height: 65)
                    .foregroundStyle(darkMode ? Color("BlobDarkBackground") : .white)
                    .overlay(
                        Circle()
                            .stroke(darkMode ? .white : .black, lineWidth: 3)
                    )
                
                Image(darkMode ? "arrow_right_white" : "arrow_right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
            }
        }
        .buttonStyle(NoOpacityButtonStyle())
    }
}

#Preview {
    ZStack{
        Color(.red)
            .ignoresSafeArea()
        
        VStack{
            NotificationTextBlob(text: "Ex est aliquip sunt excepteur id reprehenderit velit enim sunt eu ullamco duis duis elit duis aute.", showingArrow: true, showingTail: true, darkMode: true, arrowAction: {})
            
            NotificationTextBlob(text: "Ex est aliquip sunt excepteur id reprehenderit velit enim sunt eu ullamco duis duis elit duis aute.", showingArrow: true, showingTail: true, arrowAction: {})
        }
    }
}
