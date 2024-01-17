//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import SwiftUI
import SpriteKit

struct Exp11_resizable_SK: View {
    var scene: SKScene {
        let scene = resizable_SK()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        SpriteView(
            scene: scene
        )
        .ignoresSafeArea()
    }
}

class resizable_SK: SKScene {
    let circleNode = SKShapeNode(circleOfRadius: 100)
    
    override func didMove(to view: SKView) {
        circleNode.fillColor = .white
        circleNode.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(circleNode)
    }
    
//    override func didChangeSize(_ oldSize: CGSize) {
//        circleNode.position = CGPoint(x: size.width/2, y: size.height/2)
//    }
}

#Preview {
    Exp11_resizable_SK()
}
