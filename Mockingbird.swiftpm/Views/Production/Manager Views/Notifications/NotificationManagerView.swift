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
                        NotificationTextBlob(text: notificationManager.currentNotificationMessage, showingArrow: true, showingTail: true)
                            .padding(.all, 20)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
    
    func callNotification(ID: Int) {
        notificationManager.callNotification(ID: ID)
    }
    
    func closeNotification() {
        notificationManager.closeNotification()
    }
}

class NotificationManager: ObservableObject {
    @Published var isTextDisplayed: Bool = false
    @Published var currentNotificationMessage: String = ""
    
    func callNotification(ID: Int) {
        let notificationsSet = NotificationsViewModel().notifications
        
        currentNotificationMessage = notificationsSet[ID].text
        withAnimation(Animation.easeInOut(duration: NotificationTextBlob().animationMoveInDuration)) {
            isTextDisplayed = true
        }
    }
    
    func closeNotification() {
        withAnimation(Animation.easeInOut(duration: NotificationTextBlob().animationMoveInDuration)) {
            isTextDisplayed = false
        }
    }
}

#Preview {
    NotificationManagerView()
}
