//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import SwiftUI

struct MachineCollider: View {
    var rectCollider: CGRect
    
    var body: some View {
        VStack{
//            Rectangle()
//                .frame(width: rectCollider.width, height: rectCollider.height)
//                .position(x: rectCollider.midX, y: rectCollider.midY)
                
        }
        .frame(width: rectCollider.width, height: rectCollider.height)
    }
}

func createMachineCollider(height: CGFloat, width: CGFloat) -> CGRect{
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // Calculate x and y coordinates
    let x = screenWidth / 2 - width/2  // Subtract half of the rect width
    let y = screenHeight / 2 - height/2 // Subtract half of the rect height

    // Create CGRect with the calculated x, y, width, and height
    let rectCollider = CGRect(x: x, y: y, width: width, height: height)
    
    return rectCollider
}

#Preview {
    MachineCollider(rectCollider: createMachineCollider(height: 200, width: 200))
}
