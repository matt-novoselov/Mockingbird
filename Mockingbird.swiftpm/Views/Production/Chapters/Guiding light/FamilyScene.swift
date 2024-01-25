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
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(1), heavenSlider: .constant(0))
            
            HStack {
                ForEach(0..<7) { _ in
                    FamilyMember(imageName: "PH_cubes", countMemners: $countMemners)
                }
            }
            .padding()
        }
        .onChange(of: countMemners){
            if countMemners==7{
                notificationManager.callNotification(ID: 19, arrowAction: {
                    transitionManagerObservable.transitionToScene?(13)
                }, darkMode: true)
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
