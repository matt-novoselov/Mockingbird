//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI
import SpriteKit

struct ParticleView: UIViewRepresentable {
    static var scene = ParticleLayer()
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.backgroundColor = .clear
        view.presentScene(Self.scene)
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
    
    static func spawnParticle(xpos: Double, ypos: Double) {
        if let particlesTapEffect = SKEmitterNode(fileNamed: "Explosion.sks") {
            scene.addChild(particlesTapEffect)
            particlesTapEffect.position = CGPoint(x: xpos, y: scene.size.height - ypos)
        } else {
            // Handle the case where the file cannot be loaded or is not found
            print("Error loading Explosion.sks file")
        }
    }
}

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
