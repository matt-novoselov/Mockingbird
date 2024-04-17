//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 06/02/24.
//

import SwiftUI

struct MemeberButton: View {
    var selectedStyle: Int = 0
    @Binding var showingImage: Bool
    @Binding var countMemners: Int
    @Binding var canInteractWithScene: Bool
    
    var body: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                performAction()
            }
    }
    
    func performAction(){
        if !canInteractWithScene{
            return
        }
        
        if showingImage{
            return
        }
        
        countMemners+=1
        showingImage = true
    }
}
