//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 06/02/24.
//

import SwiftUI

struct MemeberButton: View {
    
    // Property that describes if an image is being shown
    @Binding var showingImage: Bool
    
    // Count how many members were alredy touched
    @Binding var countMembers: Int
    
    // Property that prevents accidential interaction with the scene until transition is complete
    @Binding var canInteractWithScene: Bool
    
    var body: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                performAction()
            }
    }
    
    // Action that happens after image is being touched
    func performAction(){
        if !canInteractWithScene{
            return
        }
        
        if showingImage{
            return
        }
        
        countMembers+=1
        showingImage = true
    }
}
