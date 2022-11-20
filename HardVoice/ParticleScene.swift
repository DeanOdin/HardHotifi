//
//  ParticleScene.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 20.11.2022.
//

import Foundation
import SpriteKit

class ParticleScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setupParticleEmitter()
        
    }
        
    private func setupParticleEmitter() {
        let particleEmitter = SKEmitterNode(fileNamed: "SparksParticle")!
        particleEmitter.position = CGPoint(x: size.width / 2, y: size.height - 50)
        addChild(particleEmitter)
    }
}
