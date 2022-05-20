//
//  PlayerObject.swift
//  SPEEDBOAT
//
//  Created by Mr. Joker on 8/14/19.
//  Copyright © 2019 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerObject : Sprite {
    
    override init() {
        super.init()
    }
    
    var isRotate: Bool = false
    
    var isRotateRight: Bool = true
    var isLeft: Bool = true
    
    var frames = [SKTexture()]
    let fire = Sprite(imageNamed: "_fire.png", size: CGSize.zero, position: CGPoint.zero, zPosition: -1)
    
    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)
        
        fire.yScale = -1
        
        fire.size = CGSize(width: size.width/2, height: size.height/2)
        fire.position = CGPoint(x: 0, y: -1 * size.height/2.1)
        
        frames.removeAll()
        for i in 1...2 {
            frames.append(SKTexture(imageNamed: "Images/_fire_\(i)"))
        }
        
        fire.run(.repeatForever(.animate(with: frames, timePerFrame: 0.1)))
        
        addChild(fire)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
