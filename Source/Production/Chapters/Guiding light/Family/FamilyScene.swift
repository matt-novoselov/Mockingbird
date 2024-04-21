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
    
    // Count amount of members that have been touched
    @State var countMembers: Int = 0
    
    // Property that controls value of the dark background
    @State public var darkSlider: Double = 0.79
    
    // Animated property that controls if each family member is being shown
    @State var showingMember_0: Bool = false
    @State var showingMember_1: Bool = false
    @State var showingMember_2: Bool = false
    @State var showingMember_3: Bool = false
    
    // Animated property of the whole family glowing effect
    @State var mainGlowing: Double = 0.0
    
    // Animated property of the heart glowing effect
    @State var heartOpacity: Double = 0.0
    
    // Property that prevents accidental interaction with the scene before transition is complete
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
                
                    // Update glowing effect
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
                    MemberButton(showingImage: $showingMember_3, countMembers: $countMembers, canInteractWithScene: $canInteractWithScene)
                    
                    MemberButton(showingImage: $showingMember_2, countMembers: $countMembers, canInteractWithScene: $canInteractWithScene)
                    
                    VStack{
                        MemberButton(showingImage: $showingMember_0, countMembers: $countMembers, canInteractWithScene: $canInteractWithScene)
                        
                        Rectangle()
                            .opacity(0)
                    }
                    
                    MemberButton(showingImage: $showingMember_1, countMembers: $countMembers, canInteractWithScene: $canInteractWithScene)
                }
                
            )
            .padding(.all, 100)
            
        }
        
        // Perform action on new member touch
        .onChange(of: countMembers){
            
            // Animate background change on member touch
            withAnimation(Animation.easeInOut(duration: 5.0)){
                darkSlider -= 0.2
            }
            
            // Call notification when all members are touched
            if countMembers==4{
                notificationManager.callNotification(ID: 17, arrowAction: {
                    transitionManagerObservable.transitionToScene?(13)
                }, darkMode: false)
            }
        }
        
        // Wait until the transition is complete to allow scene interactions
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
