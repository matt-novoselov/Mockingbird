//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI


struct Exp12_left_up_corner: View {
    @State var isTextDisplayed: Bool = false
    let notificationsSet: [Notification] = NotificationsViewModel().notifications
    
    var body: some View {
        ZStack{
            
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
//            VStack{
//                HStack{
//                    if(isTextDisplayed){
//                        NotificationTextBlob(text: notificationsSet[0].text)
//                            .padding(.all, 20)
//                    }
//                    Spacer()
//                }
//            }
//            .ignoresSafeArea()
            
            NotificationTextBlob(text: notificationsSet[0].text)
                .padding(.all, 20)
            
            Button("Button") {
                withAnimation(Animation.easeInOut(duration: NotificationTextBlob().animationMoveInDuration)) {
                    isTextDisplayed.toggle()
                }
            }
            
        }
    }
}

#Preview {
    Exp12_left_up_corner()
}
