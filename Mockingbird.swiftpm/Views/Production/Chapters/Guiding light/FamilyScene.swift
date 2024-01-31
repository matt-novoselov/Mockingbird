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
    
    @State var countMemners: Int = 0
    
    @State public var darkSlider: Double = 0.8
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: .constant(0))
            
            HStack {
                ForEach(0..<4) { _ in
                    FamilyMember(imageName: "PH_cubes", countMemners: $countMemners)
                }
            }
            .padding()
        }
        .onChange(of: countMemners){
            withAnimation(Animation.easeInOut(duration: 2.0)){
                darkSlider -= 0.2
            }
            
            if countMemners==4{
                notificationManager.callNotification(ID: 17, arrowAction: {
                    transitionManagerObservable.transitionToScene?(13)
                }, darkMode: false)
            }
        }
    }
}

struct FamilyMember: View {
    @State var isShowingShadow: Bool = false
    var imageName: String = ""
    
    @Binding var countMemners: Int
    
    var body: some View {
        Button(action: {
            if isShowingShadow{
                return
            }
            else{
                countMemners+=1
                withAnimation{
                    isShowingShadow = true
                }
            }
        })
        {
            Image(imageName)
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .glow(color: Color("MainYellow").opacity(isShowingShadow ? 0.4 : 0.0), radius: 40)
        }
        .buttonStyle(NoOpacityButtonStyle())
    }
}

#Preview {
    LayersManager(initialView: FamilyScene())
}
