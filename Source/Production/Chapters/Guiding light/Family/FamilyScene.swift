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
    
    @State var mainGlowing: Double = 0.0
    @State var heartOpacity: Double = 0.0
    
    @State var canInteractWithScene: Bool = false
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: .constant(0))
            
            ZStack {
                Image("family_base")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .white.opacity(1), radius: 100)
                
                FamilyMember(selectedStyle: 3, showingImage: $showingMember_3)
                FamilyMember(selectedStyle: 2, showingImage: $showingMember_2)
                FamilyMember(selectedStyle: 1, showingImage: $showingMember_1)
                FamilyMember(selectedStyle: 0, showingImage: $showingMember_0)
                
                Image(countMembers >= 4 ? "family_main_happy" : "family_main_sad")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .allowsHitTesting(false)
                    .glow(color: Color("MainYellow").opacity(mainGlowing), radius: 100)
                    .onChange(of: countMembers){
                        withAnimation(.easeInOut){
                            mainGlowing = Double(countMembers) / 10.0
                            heartOpacity = Double(countMembers) / 4
                        }
                    }
                
                Image("family_heart")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .allowsHitTesting(false)
                    .glow(color: Color("MainYellow").opacity(mainGlowing), radius: 100)
                    .opacity(heartOpacity)
            }
            .overlay(
                HStack{
                    MemeberButton(selectedStyle: 3, showingImage: $showingMember_3, countMemners: $countMembers, canInteractWithScene: $canInteractWithScene)
                    
                    MemeberButton(selectedStyle: 2, showingImage: $showingMember_2, countMemners: $countMembers, canInteractWithScene: $canInteractWithScene)
                    
                    VStack{
                        MemeberButton(selectedStyle: 0, showingImage: $showingMember_0, countMemners: $countMembers, canInteractWithScene: $canInteractWithScene)
                        
                        Rectangle()
                            .opacity(0)
                    }
                    
                    MemeberButton(selectedStyle: 1, showingImage: $showingMember_1, countMemners: $countMembers, canInteractWithScene: $canInteractWithScene)
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
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                canInteractWithScene = true
            }
        }
    }
}

#Preview {
    LayersManager(initialView: FamilyScene())
}
