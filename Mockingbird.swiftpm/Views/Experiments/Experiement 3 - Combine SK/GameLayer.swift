//
//  SK_Game_Layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SpriteKit

class GameLayer: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        self.size = UIScreen.main.bounds.size
        
        self.scaleMode = .resizeFill
    }
    
    public func test_call(xpos: Double, ypos: Double) {
        let trailSmoke: SKEmitterNode = SKEmitterNode(fileNamed: "MyParticle.sks")!
        
        self.addChild(trailSmoke)
        
        trailSmoke.position = CGPoint(x: xpos, y: self.size.height - ypos)
    }
}
