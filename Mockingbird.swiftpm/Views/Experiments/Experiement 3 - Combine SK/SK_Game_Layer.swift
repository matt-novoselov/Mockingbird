//
//  SK_Game_Layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SpriteKit

class SK_Game_Layer: SKScene {
    let trailSmoke: SKEmitterNode = SKEmitterNode(fileNamed: "MyParticle.sks")!
    
    override init(size: CGSize) {
        super.init(size: size)
        self.scaleMode = .resizeFill
        self.backgroundColor = .clear
        
        trailSmoke.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(trailSmoke)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            trailSmoke.position = location
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
