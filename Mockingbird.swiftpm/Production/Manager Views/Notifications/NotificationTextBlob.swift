//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct NotificationTextBlob: View {
    @State var text: String = ""
    @State var showingArrow: Bool = false
    @State var showingTail: Bool = false
    var darkMode: Bool = false
    var arrowAction: (() -> Void)?
    
    @State var shift: Int = 0
    @State var customShift: Int = 1
    @State var stateShowButton: Bool = false
    let animationMoveInDuration: Double = 1.0
    
    @State var textOpacity: Double = 1.0
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack (alignment: .top){
            Text(String(text.prefix(customShift)))
                .font(getFont(size: 32))
                .foregroundColor(.clear)
                .frame(width: 330)
                .padding()
                .background(
                    BubbleShape(trailProgress: showingTail ? 1 : 0)
                        .foregroundColor(darkMode ? Color("BlobDarkBackground") : .white)
                )
                .overlay(
                    BubbleShape(trailProgress: showingTail ? 1 : 0)
                        .stroke(darkMode ? .white : .black, lineWidth: 3)
                )
                .onChange(of: shift){ _ in
                    withAnimation{
                        customShift = shift + 12
                    }
                }
                .onChange(of: notificationManager.currentNotificationMessage){ newValue in
                    withAnimation(nil){
                        textOpacity = 0
                    }
                    withAnimation(.easeInOut){
                        text = newValue
                        textOpacity = 1
                        showingTail = notificationManager.arrowAction == nil
                    }
                    
                    withAnimation(.easeInOut(duration: 0.5)){
                        customShift = 1
                    }
                    
                    shift = 1
                    showingArrow = notificationManager.arrowAction != nil
                    typeWriter()
                }

            
            Group {
                Text(String(text.prefix(shift)))
                    .font(getFont(size: 32))
                    .foregroundColor(darkMode ? .white.opacity(textOpacity) : .black.opacity(textOpacity))
                +
                
                Text(
                    shift <= text.count ?
                    
                    String(text.suffix(text.count - shift))
                    
                    : ""
                )
                .font(getFont(size: 32))
                .foregroundColor(.clear)
                
            }
            .frame(width: 330)
            .padding()
            .clipShape(BubbleShape(trailProgress: showingTail ? 1 : 0))
            
            ZStack (alignment: .bottomTrailing){
                Text(text)
                    .font(getFont(size: 32))
                    .foregroundColor(.clear)
                    .frame(width: 330)
                    .padding()
                
                if showingArrow{
                    ArrowCircleButton(darkMode: darkMode, arrowAction: arrowAction ?? nil)
                        .offset(x: 20, y: 20)
                        .scaleEffect(stateShowButton ? 1.0 : 0.0)
                        .environmentObject(notificationManager)
                }
            }
            
        }
        .shadow(color: .black.opacity(darkMode ? 0 : 0.08), radius: 20)
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + animationMoveInDuration - 0.25) {
                typeWriter()
            }
        }
        .transition(.move(edge: .leading))
    }
    
    func typeWriter() {
        if shift < text.count {
            let interval: Double = notificationManager.isDebug ? 0.0005 : 0.03
            
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                shift += 1
                typeWriter()
            }
        }
        else{
            // On typewriter animation end
            handleEndOfAnimation()
        }
    }
    
    func handleEndOfAnimation(){
        notificationManager.isTextPrintFinished = true
        
        if showingArrow{
            withAnimation{
                stateShowButton = true
            }
        }
    }
}

struct ArrowCircleButton: View {
    var darkMode: Bool = false
    var arrowAction: (() -> Void)?
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        Button(
            action: {
                notificationManager.closeNotification()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + NotificationTextBlob().animationMoveInDuration) {
                    arrowAction?()
                }
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
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
            }
        }
        .buttonStyle(NoOpacityButtonStyle())
    }
}

#Preview {
    LayersManager(initialView:
                    VStack{
        NotificationTextBlob(text: NotificationsViewModel().notifications[9].text, showingArrow: true, showingTail: true, darkMode: true, arrowAction: {})
        
        NotificationTextBlob(text: NotificationsViewModel().notifications[9].text, showingArrow: true, showingTail: true, arrowAction: {})
    }
    )
}
