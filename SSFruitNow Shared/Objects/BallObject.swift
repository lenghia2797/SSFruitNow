//
//  BallObject.swift
//  New
//
//  Created by hehehe on 7/5/21.
//

import Foundation
import SpriteKit

class BallObject : Sprite {
    override init() {
        super.init()
    }
    
    let dot = Sprite(imageNamed: "_ball_1", size: CGSize.zero, position: CGPoint.zero, zPosition: -1)
    
    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)
        
//        var animateFrames = [SKTexture]()
//        for i in 1...10 {
//            animateFrames.append(SKTexture(imageNamed: "Images/_coin_1_" + "\(i)"))
//        }
//
//        run(SKAction.repeatForever(SKAction.animate(with: animateFrames,
//                                                    timePerFrame: 0.05,
//                                                    resize: false,
//                                                    restore: false)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
