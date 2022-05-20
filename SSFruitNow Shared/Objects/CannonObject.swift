//
//  CannonObject.swift
//  New
//
//  Created by hehehe on 7/5/21.
//

import Foundation
import SpriteKit

class CannonObject : Sprite {
    override init() {
        super.init()
    }
    
    var dot = Sprite()
    var bullet = Sprite()
    var rope = Sprite()
    var back = Sprite()
    var isBulletNotFired: Bool = true
    
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
