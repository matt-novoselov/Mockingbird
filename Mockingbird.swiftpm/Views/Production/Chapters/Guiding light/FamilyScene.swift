//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct FamilyScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var isShowingShadow: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            Button(action: {
                isShowingShadow.toggle()
            })
            {
                
                Image("PH_cubes")
                    .glow(color: Color("MainYellow").opacity(isShowingShadow ? 0.4 : 0.0), radius: 40)
                
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    LayersManager(initialView: FamilyScene())
}
