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
                        NotificationTextBlob(text: notificationManager.currentNotificationMessage, showingArrow: true, showingTail: true, arrowAction: notificationManager.arrowAction)
                            .padding(.all, 20)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
    
    func callNotification(ID: Int, arrowAction: @escaping () -> Void) {
        notificationManager.callNotification(ID: ID, arrowAction: arrowAction)
    }
    
    func closeNotification() {
        notificationManager.closeNotification()
    }
}

class NotificationManager: ObservableObject {
    @Published var isTextDisplayed: Bool = false
    @Published var currentNotificationMessage: String = ""
    @Published var arrowAction: () -> Void = {}
    
    func callNotification(ID: Int, arrowAction: @escaping () -> Void) {
        let notificationsSet = NotificationsViewModel().notifications
        self.arrowAction = arrowAction
        
        currentNotificationMessage = notificationsSet[ID].text
        withAnimation(Animation.easeInOut(duration: NotificationTextBlob(arrowAction: {}).animationMoveInDuration)) {
            isTextDisplayed = true
        }
    }
    
    func closeNotification() {
        withAnimation(Animation.easeInOut(duration: NotificationTextBlob(arrowAction: {}).animationMoveInDuration)) {
            isTextDisplayed = false
        }
    }
}

#Preview {
    NotificationManagerView()
}
