//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI


struct NotificationManagerView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    if(notificationManager.isTextDisplayed){
                        NotificationTextBlob(
                            text: notificationManager.currentNotificationMessage,
                            showingArrow: notificationManager.arrowAction != nil,
                            showingTail: notificationManager.arrowAction == nil,
                            darkMode: notificationManager.darkMode ?? false,
                            arrowAction: notificationManager.arrowAction ?? nil
                        )
                        .environmentObject(notificationManager)
                        .padding(.all, 20)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            if notificationManager.isDebug{
                VStack{
                    Button("Button") {
                        notificationManager.callNotification(ID: 0)
                    }
                    
                    Button("Button") {
                        notificationManager.callNotification(ID: 1)
                    }
                }
            }

        }
    }
}


class NotificationManager: ObservableObject {
    @Published var isDebug: Bool = false
    // - - - - - - - - - - - - - - - - - - - - //
    @Published var isTextDisplayed: Bool = false
    @Published var currentNotificationMessage: String = ""
    @Published var arrowAction: (() -> Void)? = nil
    @Published var darkMode: Bool?
    @Published var isTextPrintFinished: Bool = true
    
    func callNotification(ID: Int, arrowAction: (() -> Void)? = nil, darkMode: Bool? = false) {
        let notificationsSet = NotificationsViewModel().notifications
        self.arrowAction = arrowAction
        self.darkMode = darkMode
        
        self.isTextPrintFinished = false
        
        withAnimation(nil){
            currentNotificationMessage = notificationsSet[ID].text
        }

        withAnimation(Animation.easeInOut(duration: NotificationTextBlob(arrowAction: {}).animationMoveInDuration)) {
            isTextDisplayed = true
        }
    }
    
    func closeNotification() {
        withAnimation(Animation.easeInOut(duration: NotificationTextBlob(arrowAction: {}).animationMoveInDuration)) {
            isTextDisplayed = false
            arrowAction = nil
        }
    }
}

#Preview {
    NotificationManagerView()
        .environmentObject(NotificationManager())
}
