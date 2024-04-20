//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI
import SpriteKit


struct ParticleView: UIViewRepresentable {
    
    // Initiate the scene
    static var scene = ParticleLayer()
    
    // Set background color to transparent
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.backgroundColor = .clear
        view.presentScene(Self.scene)
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
    
    // Spawn particles at a new global position
    static func spawnParticle(xpos: Double, ypos: Double) {
        if let particlesTapEffect = SKEmitterNode(fileNamed: "Explosion.sks") {
            // Add new instance of particles
            scene.addChild(particlesTapEffect)
            particlesTapEffect.position = CGPoint(x: xpos, y: scene.size.height - ypos)
        } else {
            // Handle the case where the file cannot be loaded or is not found
            print("Error loading Explosion.sks file")
        }
    }
}

// SwiftUI wrapper for Sprite Kit scene
struct SwiftuiParticles: View {
    var body: some View {
        ParticleView()
            .allowsHitTesting(false)
            .ignoresSafeArea()
    }
}

#Preview {
    SwiftuiParticles()
}
