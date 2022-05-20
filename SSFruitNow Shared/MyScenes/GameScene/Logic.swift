//
//  GameLayer.swift
//  GOALKR
//
//  Created by Admin on 7/31/20.
//  Copyright © 2020 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func passLevel(){
        if level != 15 {
            UserDefaults.standard.set(level+1 , forKey: "level")
            if level + 1 > UserDefaults.standard.integer(forKey: "maxLevel"){
                UserDefaults.standard.set(level+1 , forKey: "maxLevel")
            }
            
            Sounds.sharedInstance().playSound(soundName: "Sounds/sound_score.mp3")
            self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .doorsOpenHorizontal(withDuration: 0.5))
        } else {
            self.changeSceneTo(scene: MenuScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
        }
    }
    
    func collisionBetweenBallVsGoal(_ball: Sprite, _goal: Sprite) {
        for b in balls {
            if b == _ball {
                b.removeFromParent()
                updateScore(value: 1, position: _goal.position)
            }
        }
    }
    
    func collisionBetweenBallVsWall(_ball: Sprite, _goal: Sprite) {
        for b in balls {
            if b == _ball {
                b.removeFromParent()
                addExplodeEffect(pos: b.position, imageNamed: "_bomb_explode")
                Sounds.sharedInstance().playSound(soundName: "Sounds/sound_fail")
                self.run(.sequence([
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.changeSceneTo(scene: EndScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
                    }
                ]))
            }
        }
    }
    
    func collisionBulletVsBall(_bullet: Sprite, _ball: Sprite) {
        for c in cannons {
            if c.bullet == _bullet {
                c.bullet.removeFromParent()
                c.dot.removeFromParent()
                c.rope.removeFromParent()
                c.removeFromParent()
                cannons.remove(c)
                
                if let ex = SKEmitterNode(fileNamed: "Explode_5.sks") {
                    
                    ex.position = c.bullet.position
                    addChild(ex)
                }
                
                Sounds.sharedInstance().playSound(soundName: "Sounds/sound_explode")
            }
        }
    }
    
    func removeAllCannon() {
        for c in cannons {
            c.bullet.removeFromParent()
            c.dot.removeFromParent()
            c.rope.removeFromParent()
            c.removeFromParent()
            cannons.remove(c)
        }
    }
    
    func removeAllWindmill() {
        for w in windmills {
            w.removeFromParent()
            windmills.remove(w)
        }
    }
    
    func removeAllGoal() {
        for g in goals {
            g.removeFromParent()
            goals.remove(g)
        }
    }
    
    func removeAllLine() {
        for l in lines {
            l.removeFromParent()
            lines.remove(l)
        }
    }
}
