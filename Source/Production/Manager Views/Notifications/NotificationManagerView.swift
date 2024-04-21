//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI


// View responsible for managing notifications
struct NotificationManagerView: View {
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    // Animated bool that controls if notification is present or not
    @State var localIsTextDisplayed: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    if(localIsTextDisplayed){
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
                .onChange(of: notificationManager.isTextDisplayed){
                    // Update the local bool, if isTextDisplayed changes in the Notification Manager
                    withAnimation(Animation.easeInOut(duration: NotificationTextBlob(arrowAction: {}).animationMoveInDuration)) {
                        localIsTextDisplayed = notificationManager.isTextDisplayed
                    }
                }
                
                Spacer()
            }
            
            // Buttons for debugging purposes
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


// Notification Manager
class NotificationManager: ObservableObject {
    
    // Enable or disable debugging
    @Published var isDebug: Bool = false
    
    // - - - - - - - - - - - - - - - - - - - - //
    
    // Bool that controls if the notification is displayed
    @Published var isTextDisplayed: Bool = false
    
    // Text for notification
    @Published var currentNotificationMessage: String = ""
    
    // Action for notification arrow
    @Published var arrowAction: (() -> Void)? = nil
    
    // Style of the notification
    @Published var darkMode: Bool?
    
    // Bool that controls if the print animation is finished
    @Published var isTextPrintFinished: Bool = true
    
    // Function that calls a new notification from the stack
    func callNotification(ID: Int, arrowAction: (() -> Void)? = nil, darkMode: Bool? = false) {
        withAnimation(nil){
            let notificationsSet = NotificationsViewModel().notifications
            self.arrowAction = arrowAction
            self.darkMode = darkMode
            
            self.isTextPrintFinished = false
            currentNotificationMessage = notificationsSet[ID].text
            
            isTextDisplayed = true
        }
    }
    
    // Function that closes and hides notification
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
