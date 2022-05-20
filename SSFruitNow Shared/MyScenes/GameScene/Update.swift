//
//  UpdateLayer.swift
//  AnimalShape
//
//  Created by hehehe on 7/1/21.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func moveBackGround() {
        self.enumerateChildNodes(withName: "background") { (node, error) in
            node.position.y -= 0.85
            if node.position.y < -self.size.height/2 {
                node.position.y += self.size.height*3
            }
        }
         
    }
    
    func updateAllLineOverTime() {
        for c in cannons {
            updateLine(line: c.rope, objSpr1: c.bullet, objSpr2: c.dot)
        }
        
    }
    
    func updateLine(line: Sprite, objSpr1 : Sprite, objSpr2 : Sprite) {
        let lengthLine = sqrt(pow(objSpr1.position.x - objSpr2.position.x, 2) + pow(objSpr1.position.y - objSpr2.position.y, 2))
        line.size = CGSize(width: lengthLine, height: 6)
        
        line.position = CGPoint(x: (objSpr1.position.x + objSpr2.position.x) / 2, y: (objSpr1.position.y + objSpr2.position.y) / 2)
        line.zRotation = atan((objSpr2.position.y - objSpr1.position.y) / (objSpr2.position.x - objSpr1.position.x))
    }
    
    func updateProgressBar() {
        if progressX > 0 {
            progressX -= progressBarDec
            progressBar.setXProgress(xProgress: progressX)
        } else {
            changeSceneTo(scene: EndScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
        }
    }
    
    func updateProgressX(value: CGFloat) {
        progressX += value
        if progressX > 1.05 {
            progressX = 1.05
        }
        
        progressBar.setXProgress(xProgress: progressX)
    }
    
    func updateScore( value:Int, position:CGPoint) {
        
        score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        
        score += value
        if (score > UserDefaults.standard.integer(forKey: GameConfig.bestScore)) {
            UserDefaults.standard.set(score, forKey: GameConfig.bestScore)
            best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        }
        UserDefaults.standard.set(score, forKey: GameConfig.currentScore)
        
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            scoreLbl.changeTextWithAnimationScaled(withText: "Score: \(score)")
        } else {
            scoreLbl.changeTextWithAnimationScaled(withText: "Score: \(score) , Best: \(best)")
        }
        
//        scoreLbl.attributedText = setStrokeForTextLbl(label: scoreLbl)
        
        Sounds.sharedInstance().playSound(soundName: "Sounds/sound_score.mp3")
        let add_oneLbl:Label
        let addLblPos:CGPoint = CGPoint(x: position.x+40, y: position.y+40)
        add_oneLbl = Label(text: "+\(value)", fontSize: 35, fontName: GameConfig.fontText, color: UIColor.red, position: addLblPos, zPosition: 5)

        add_oneLbl.run(SKAction.sequence([SKAction.scale(by: 1.4, duration: 0.5),
                                          SKAction.removeFromParent()
        ]))
        addChild(add_oneLbl)
        
        if let ex = SKEmitterNode(fileNamed: "Explode_3.sks") {
            
            ex.position = position
            addChild(ex)
        }
        
//        if levelScore < 10 && levelScore*2 < score {
//            levelScore += 1
//            progressBarDec *= 1.02
//        }
//
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            if score == targetScore {
                self.run(.sequence([.wait(forDuration: 0.5), .run {
                    self.passLevel()
                }]))
            }
        } else {
            endlessModeRun()
            progressX = 1
            progressBar.setXProgress(xProgress: progressX)
        }
        
    }
}
