//
//  GameScene.swift
//  SPEEDBOAT
//
//  Created by Mr. Joker on 8/13/19.
//  Copyright © 2019 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene : Scene, SKPhysicsContactDelegate {
    
    var backgrounds = [Sprite()]
              
    var gameEnd:Bool = false
    var level:Int = 0
    let toastLbl = Label(text: "Level: ", fontSize: 35, fontName: GameConfig.fontText, color: GameConfig.textColor, position: CGPoint.zero, zPosition: 7)
    let levelLbl = Label(text: "Level: 1", fontSize: 35, fontName: GameConfig.fontText, color: GameConfig.textColor, position: CGPoint.withPercent(50, y: 90), zPosition: 7)
    enum physicDefine:UInt32 {
        
        case bullet = 1
        
        case ball = 2
        
        case line = 4
        
        case wall = 8
        
        case ground = 16
        
        case goal = 32
    }
    
    var isMenuPopupHidden = true
    
    // GameLayer
    var location0: CGPoint = CGPoint.zero
    var isProcessing: Bool = false
    
    var progressBar = IMProgressBar(emptyImageName: "spr_progress_bar",filledImageName: "spr_progress_bar_level")
    var progressX: CGFloat = 1
    var progressBarDec: CGFloat = 0
    
    var windmills = [SKSpriteNode()]
    
    var moveNode:SKNode?
    
    var balls = [BallObject()]
    var bullets = [Sprite()]
    var ropes = [Sprite()]
    var dots = [Sprite()]
    var cannons = [CannonObject()]
    var goals = [Sprite()]
    var lines = [Sprite()]
    
    var targetScore: Int = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.physicsWorld.contactDelegate = self
        
        setupGame()
        
    }
    
    override func update(_ currentTime: TimeInterval) {

        updateProgressBar()

        updateAllLineOverTime()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if soundBtn.contains(location) {
                soundBtn.run(SKAction.scale(to: 0.85, duration: 0.025))
            } else {
                for c in cannons {
                    if c.bullet.contains(location) && c.isBulletNotFired {
                        moveNode = c.bullet
                        moveNode?.position = c.bullet.position
                    }
                }
            }

            touchDownButtons(atLocation: location)
            location0 = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, moveNode != nil {
            let location = touch.location(in: self)

            moveNode?.run(.move(to: location, duration: 0.2))

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)

            soundBtn.changeSwitchState(ifInLocation: location)
            
            if backBtn.contains(location) {
                if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
                    self.changeSceneTo(scene: LevelScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
                } else if UserDefaults.standard.integer(forKey: GameConfig.mode) == 1 {
                    self.changeSceneTo(scene: MenuScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
                }
                
            } else {
                for c in cannons {
                    if c.bullet == moveNode {
                        if calDistance(pos0: c.bullet.position, pos1: c.dot.position) > Double(c.bullet.size.width*0.75) {
                            c.bullet.physicsBody?.applyForce(CGVector(dx: (c.dot.position.x - c.bullet.position.x) * 15, dy: (c.dot.position.y - c.bullet.position.y) * 15 ) )
                            c.rope.isHidden = true
                            c.dot.isHidden = true
                            c.isBulletNotFired = false
                            c.bullet.physicsBody?.affectedByGravity = true
                        } else {
                            c.bullet.run(.move(to: c.dot.position, duration: 0.2))
                        }
                    }
                }
                
                moveNode = nil

            }
            
        }
        
        soundBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
        touchUpAllButtons()
        
    }
    
    func didBegin(_ contact : SKPhysicsContact) {
        let contactMark = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if gameEnd==false {
            
            switch contactMark {

            case physicDefine.ball.rawValue | physicDefine.goal.rawValue:
                guard firstBody.node == nil || secondBody.node == nil else {
                    collisionBetweenBallVsGoal(_ball: firstBody.node as! Sprite, _goal: secondBody.node as! Sprite)
                    return
                }
            case physicDefine.bullet.rawValue | physicDefine.ball.rawValue:
                guard firstBody.node == nil || secondBody.node == nil else {
                    collisionBulletVsBall(_bullet: firstBody.node as! Sprite, _ball: secondBody.node as! Sprite)
                    return
                }
            case physicDefine.ball.rawValue | physicDefine.wall.rawValue:
                guard firstBody.node == nil || secondBody.node == nil else {
                    collisionBetweenBallVsWall(_ball: firstBody.node as! Sprite, _goal: secondBody.node as! Sprite)
                    return
                }
            default:
                return
            }
        }
    }
    
}
