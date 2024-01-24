//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct FamilyScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    
    @State var isShowingShadow: Bool = false
    
    var body: some View {
        Button(action: {
            isShowingShadow.toggle()
        })
        {
            
            Image("PH_cubes")
                .glow(color: Color("MB_main_yellow").opacity(isShowingShadow ? 0.4 : 0.0), radius: 40)
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FamilyScene()
}
