//
//  File.swift
//  
//
//  Created by Matt Novoselov on 06/02/24.
//

import SwiftUI

struct FamilyMember: View {
    @State var isShowingShadow: Bool = false
    @State var imageName: String = ""
    
    @Binding var countMemners: Int
    
    @State var allowHitTesting: Bool = true
    
    let familyArray: [[String]] = [
        ["family_2_empty", "family_2_filled"],
        ["family_3_empty", "family_3_filled"],
        ["family_4_empty", "family_4_filled"],
        ["family_5_empty", "family_5_filled"],
    ]
    
    var selectedStyle: Int = 0
    
    var body: some View {
        Button(action: {
            if isShowingShadow{
                return
            }
            else{
                countMemners+=1
                withAnimation{
                    isShowingShadow = true
                    imageName = familyArray[selectedStyle][1]
                    allowHitTesting = false
                }
            }
        })
        {
            Image(imageName)
                .interpolation(.high)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .allowsHitTesting(allowHitTesting)
                .glow(color: Color("MainYellow").opacity(isShowingShadow ? 0.3 : 0.0), radius: 70)
        }
        .buttonStyle(NoOpacityButtonStyle())
        .onAppear(){
            imageName = familyArray[selectedStyle][0]
        }
    }
}
