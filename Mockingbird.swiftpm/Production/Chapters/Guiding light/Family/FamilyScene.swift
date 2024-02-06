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
    
    @State var showingMember_0: Bool = false
    @State var showingMember_1: Bool = false
    @State var showingMember_2: Bool = false
    @State var showingMember_3: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: .constant(0))
            
            ZStack {
                Image("family_base")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                FamilyMember(selectedStyle: 3, showingImage: $showingMember_3)
                FamilyMember(selectedStyle: 2, showingImage: $showingMember_2)
                FamilyMember(selectedStyle: 1, showingImage: $showingMember_1)
                FamilyMember(selectedStyle: 0, showingImage: $showingMember_0)
                
                Image(countMembers >= 4 ? "family_main_happy" : "family_main_sad")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .allowsHitTesting(false)
            }
            .overlay(
                HStack{
                    MemeberButton(selectedStyle: 3, showingImage: $showingMember_3, countMemners: $countMembers)
                    
                    MemeberButton(selectedStyle: 2, showingImage: $showingMember_2, countMemners: $countMembers)
                    
                    VStack{
                        MemeberButton(selectedStyle: 0, showingImage: $showingMember_0, countMemners: $countMembers)
                        
                        Rectangle()
                            .opacity(0)
                    }
                    
                    MemeberButton(selectedStyle: 1, showingImage: $showingMember_1, countMemners: $countMembers)
                }
                
            )
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
