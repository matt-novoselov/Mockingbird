//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI


// Animated and customized Text Blob
struct NotificationTextBlob: View {
    
    // Text that goes inside of the notification
    @State var text: String = ""
    
    // Property that decribes if an arrow will be shown after text print is complete
    @State var showingArrow: Bool = false
    
    // Property that describes if tail is shown
    @State var showingTail: Bool = false
    
    // Custom style that depends on dark or light modes
    var darkMode: Bool = false
    
    // Action that should be performed after click on the arrow button
    var arrowAction: (() -> Void)?
    
    // Typewriter shift of the slice of the text
    @State var shift: Int = 0
    
    // Animated typewriter shift for bubble shape
    @State var animatedShift: Int = 1
    
    // Bool that controls if the arrow button should be shown
    @State var stateShowButton: Bool = false
    
    // Animation duration for bubble move in
    let animationMoveInDuration: Double = 1.0
    
    // Animated opacity of the text of the notification
    @State var textOpacity: Double = 1.0
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack (alignment: .top){
            Text(String(text.prefix(animatedShift)))
                .font(getFont(size: 32))
                .foregroundColor(.clear)
                .frame(width: 330)
                .padding()
            
                .background{
                    // Main background
                    BubbleShape(trailProgress: showingTail ? 1 : 0)
                        .foregroundColor(darkMode ? Color("BlobDarkBackground") : .white)
                }
            
                .overlay{
                    // Stroke
                    BubbleShape(trailProgress: showingTail ? 1 : 0)
                        .stroke(darkMode ? .white : .black, lineWidth: 3)
                }
            
                .onChange(of: shift){
                    // Update the animated shift so it's slightly faster than the typical one
                    withAnimation{
                        animatedShift = shift + 12
                    }
                }
            
                // Reset notification to display new text
                .onChange(of: notificationManager.currentNotificationMessage){
                    
                    withAnimation(nil){
                        textOpacity = 0
                    }
                    withAnimation(.easeInOut){
                        text = notificationManager.currentNotificationMessage
                        textOpacity = 1
                        showingTail = notificationManager.arrowAction == nil
                    }
                    
                    withAnimation(.easeInOut(duration: 0.5)){
                        animatedShift = 1
                    }
                    
                    shift = 1
                    showingArrow = notificationManager.arrowAction != nil
                    typeWriter()
                    
                }
            
            // Slicing the text
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
            
            // Descibe bubble shape
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
                        .shadow(color: .black.opacity(darkMode ? 0 : 0.1), radius: 20)
                        .shadow(color: .white.opacity(darkMode ? 0.2 : 0), radius: 20)
                }
            }
            
        }
        .shadow(color: .black.opacity(darkMode ? 0 : 0.13), radius: 20)
        .onAppear(){
            
            // Start typewriter animation after appear
            DispatchQueue.main.asyncAfter(deadline: .now() + animationMoveInDuration - 0.25) {
                typeWriter()
            }
        }
        .transition(.move(edge: .leading))
    }
    
    // Function that handles typewriter animation and text slicing
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
    
    // Action that happens on the end of text print
    func handleEndOfAnimation(){
        notificationManager.isTextPrintFinished = true
        
        if showingArrow{
            withAnimation{
                stateShowButton = true
            }
        }
    }
}

// View for arrow button
struct ArrowCircleButton: View {
    
    // Custom style for dark and light modes
    var darkMode: Bool = false
    
    // Action that should be performed after click on the arrow button
    var arrowAction: (() -> Void)?
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        Button(
            action: {
                // Close notification before performing an action
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
