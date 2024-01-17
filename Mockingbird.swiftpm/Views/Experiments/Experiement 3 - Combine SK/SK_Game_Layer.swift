//
//  SK_Game_Layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SpriteKit

class SK_Game_Layer: SKScene {
    let trailSmoke: SKEmitterNode = SKEmitterNode(fileNamed: "MyParticle.sks")!
        
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        self.size = UIScreen.main.bounds.size
        
        self.addChild(trailSmoke)
    }
    
    public func test_call(xpos: Double, ypos: Double) {
        trailSmoke.position = CGPoint(x: xpos, y: self.size.height - ypos)
    }
}
