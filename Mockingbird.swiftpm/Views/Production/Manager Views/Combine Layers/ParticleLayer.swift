//
//  SK_Game_Layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SpriteKit

class ParticleLayer: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        self.size = UIScreen.main.bounds.size
        
        self.scaleMode = .resizeFill
    }
    
    public func test_call(xpos: Double, ypos: Double) {
        let particlesTapEffect: SKEmitterNode = SKEmitterNode(fileNamed: "MyParticle.sks")!
        
        self.addChild(particlesTapEffect)
        
        particlesTapEffect.position = CGPoint(x: xpos, y: self.size.height - ypos)
    }
}
