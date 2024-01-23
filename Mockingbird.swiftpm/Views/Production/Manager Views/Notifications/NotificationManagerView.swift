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
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    if(isTextDisplayed){
                        NotificationTextBlob(text: "Pursue happiness through indirect means. Rather than relying on substances or temporary escapes, try to find happiness in the present moment.", showingArrow: true, showingTail: true)
                            .padding(.all, 20)
                    }
                    Spacer()
                }
                
                Spacer()
            }
            
            Button("Test call notification") {
                withAnimation(Animation.easeInOut(duration: NotificationTextBlob().animationMoveInDuration)) {
                    isTextDisplayed.toggle()
                }
            }
            
        }
    }
}

#Preview {
    NotificationManagerView()
}
