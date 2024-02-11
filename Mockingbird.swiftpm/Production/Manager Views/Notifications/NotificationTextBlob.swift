//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct NotificationTextBlob: View {
    var text: String = ""
    @State var proxyText: String = ""
    var showingArrow: Bool = false
    @State var proxyShowingArrow: Bool = false
    var showingTail: Bool = false
    var darkMode: Bool = false
    var arrowAction: (() -> Void)?
    
    @State var shift: Int = 0
    @State var customShift: Int = 1
    @State var stateShowButton: Bool = false
    let animationMoveInDuration: Double = 1.0
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack (alignment: .top){
            Text(String(proxyText.prefix(customShift)))
                .font(getFont(size: 32))
                .foregroundColor(.clear)
                .frame(width: 330)
                .padding()
                .background(
                    BubbleShape(showingTrail: showingTail)
                        .foregroundColor(darkMode ? Color("BlobDarkBackground") : .white)
                )
                .overlay(
                    BubbleShape(showingTrail: showingTail)
                        .stroke(darkMode ? .white : .black, lineWidth: 3)
                )
                .onChange(of: shift){ _ in
                    withAnimation{
                        customShift = shift + 12
                    }
                }
                .onChange(of: text){ newValue in
                    proxyText = newValue
                    shift = 1
                    
                    withAnimation(){
                        customShift = 1
                    }
                    
                    typeWriter()
                }
                .onAppear(){
                    proxyText = text
                    proxyShowingArrow = showingArrow
                }
                .onChange(of: showingArrow){ newValue in
                    proxyShowingArrow = newValue
                }
            
            Group {
                Text(String(text.prefix(shift)))
                    .font(getFont(size: 32))
                    .foregroundColor(darkMode ? .white : .black)
                +
                
                Text(
                    shift <= proxyText.count ?
                    
                    String(proxyText.suffix(proxyText.count - shift))
                    
                    : ""
                )
                .font(getFont(size: 32))
                .foregroundColor(.clear)
                
            }
            .frame(width: 330)
            .padding()
            .clipShape(BubbleShape(showingTrail: showingTail))
            
            ZStack (alignment: .bottomTrailing){
                Text(proxyText)
                    .font(getFont(size: 32))
                    .foregroundColor(.clear)
                    .frame(width: 330)
                    .padding()
                
                if proxyShowingArrow{
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
        if shift < proxyText.count {
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
        
        if proxyShowingArrow{
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
