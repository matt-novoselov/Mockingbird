//
//  SK_Game_Layer.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SpriteKit

// Sprite Kit particle scene
class ParticleLayer: SKScene {
    override func didMove(to view: SKView) {
        
        // Set background color to transparent
        self.backgroundColor = .clear
        
        // Set the size of the screen equal to the size of the device
        self.size = UIScreen.main.bounds.size
        
        self.scaleMode = .resizeFill
    }
}
