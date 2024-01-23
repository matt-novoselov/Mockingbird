//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import SwiftUI

struct DrugsScene: View {
    @State var isShaken: Bool = false
    
    var body: some View {
        VStack{
            Text("Something fell out")
                .opacity(isShaken ? 1 : 0)
            
            DraggableShakableView(handleShake: handleShake)
        }
    }
    
    func handleShake() {
        isShaken = true
    }
}

#Preview {
    DrugsScene()
}
