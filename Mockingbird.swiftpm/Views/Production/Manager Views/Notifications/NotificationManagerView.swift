//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI


struct NotificationManagerView: View {
    @State var isTextDisplayed: Bool = false
    let notificationsSet: [Notification] = NotificationsViewModel().notifications
    
    @State var currentNotificationMessage: String = ""
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    if(isTextDisplayed){
                        NotificationTextBlob(text: currentNotificationMessage, showingArrow: true, showingTail: true)
                            .padding(.all, 20)
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
    
    func CallNotification(ID: Int){
        currentNotificationMessage = notificationsSet[ID].text
        
        withAnimation(Animation.easeInOut(duration: NotificationTextBlob().animationMoveInDuration)) {
            isTextDisplayed = true
        }
    }
    
    func CloseNotification(){
        withAnimation(Animation.easeInOut(duration: NotificationTextBlob().animationMoveInDuration)) {
            isTextDisplayed = false
        }
    }
}

#Preview {
    NotificationManagerView()
}
