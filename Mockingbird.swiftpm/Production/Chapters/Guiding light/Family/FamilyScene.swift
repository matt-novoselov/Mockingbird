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
    
    @State var countMembers: Int = 0
    @State public var darkSlider: Double = 0.79
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: .constant(0))
            
            ZStack {
                ForEach((0..<4).reversed(), id: \.self) { index in
                    FamilyMember(countMemners: $countMembers, selectedStyle: index)
                }
                
                Image(countMembers >= 4 ? "family_1_filled" : "family_1_empty")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .allowsHitTesting(false)
            }
            .padding(.all, 100)
        }
        .onChange(of: countMembers){
            withAnimation(Animation.easeInOut(duration: 5.0)){
                darkSlider -= 0.2
            }
            
            if countMembers==4{
                notificationManager.callNotification(ID: 17, arrowAction: {
                    transitionManagerObservable.transitionToScene?(13)
                }, darkMode: false)
            }
        }
    }
}

#Preview {
    LayersManager(initialView: FamilyScene())
}
