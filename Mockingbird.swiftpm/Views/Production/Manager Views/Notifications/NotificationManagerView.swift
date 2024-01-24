//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI


struct NotificationManagerView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    let notificationsSet: [Notification] = NotificationsViewModel().notifications
    
    @State var currentNotificationMessage: String = ""
    
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
                        .padding(.all, 20)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
}


class NotificationManager: ObservableObject {
    @Published var isTextDisplayed: Bool = false
    @Published var currentNotificationMessage: String = ""
    @Published var arrowAction: (() -> Void)? = nil
    @Published var darkMode: Bool?
    
    func callNotification(ID: Int, arrowAction: (() -> Void)? = nil, darkMode: Bool? = false) {
        let notificationsSet = NotificationsViewModel().notifications
        self.arrowAction = arrowAction
        self.darkMode = darkMode
        
        currentNotificationMessage = notificationsSet[ID].text
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
}
