//
//  File.swift
//  
//
//  Created by Matt Novoselov on 06/02/24.
//

import SwiftUI

struct FamilyMember: View {
    
    // Set style for each button
    var selectedStyle: Int = 0
    
    // Property that describes if an image is being shown
    @Binding var showingImage: Bool
    
    @State private var showingMemberImage: Bool = false
    
    // Array of images for each family member style
    let familyArray: [String] = [
        "family_1_filled",
        "family_2_filled",
        "family_3_filled",
        "family_4_filled",
    ]
    
    var body: some View {
        
        ZStack{
            if showingMemberImage{
                Image(familyArray[selectedStyle])
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .glow(color: Color("MainYellow").opacity(0.3), radius: 100)
            }
        }
        
        // Animation to display new overlay image
        .onChange(of: showingImage){
            withAnimation(.easeInOut(duration: 0.8)){
                showingMemberImage = true
            }
        }
        
    }
}
