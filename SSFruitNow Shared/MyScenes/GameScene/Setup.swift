//
//  ControlLayer.swift
//  GOALKR
//
//  Created by Admin on 7/31/20.
//  Copyright © 2020 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func setupGame(){
        setInterFace()
        
        setArr()
        
        addGroundAndWall()
        
        setMode()
        
    }
    
    func setInterFace(){
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        UserDefaults.standard.set(0, forKey: GameConfig.currentScore)
        addChild([backBtn, backgroundSpr, soundBtn])
        
//        backgroundSpr.isHidden = true
        
    }
    
    func setArr() {
        windmills.removeAll()
        balls.removeAll()
        bullets.removeAll()
        ropes.removeAll()
        dots.removeAll()
        cannons.removeAll()
        goals.removeAll()
        lines.removeAll()
        
    }
    
    func setMode() {
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            setLevelLbl()
            addProgressbar()
            let t:CGFloat = 15
            progressBarDec = 0.01929/(t + CGFloat(level)*2 )
            setGameLevel()
        } else {
            addProgressbar()
            let t:CGFloat = 20
            progressBarDec = 0.01929/(t)
            endlessMode()
        }
    }
    
    func addLine(percentWidth: CGFloat, _pos: CGPoint, zRotation: CGFloat = 0) {
        let lineName = "_line"
        let line = Sprite(imageNamed: lineName, size: sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/" + lineName).size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: percentWidth)), position: _pos, zPosition: 3)
        
        addChild(line)
        
        line.physicsBody = SKPhysicsBody(rectangleOf: line.size)
        line.physicsBody?.isDynamic = false
        
        line.physicsBody?.categoryBitMask = physicDefine.line.rawValue
        line.physicsBody?.contactTestBitMask = physicDefine.bullet.rawValue | physicDefine.ball.rawValue
        line.physicsBody?.collisionBitMask = physicDefine.bullet.rawValue | physicDefine.ball.rawValue
        
        if zRotation != 0 {
            line.zRotation = zRotation
        }
        
        lines.append(line)
    }
    
    func addCannon(_pos: CGPoint) {
        let cannon = CannonObject(imageNamed: "", size: CGSize.zero, position: CGPoint.zero, zPosition: 3)
        
        let nameBullet = Int.random(in: 1...2)
        cannon.bullet = Sprite(imageNamed: "_bullet_\(nameBullet)", size: CGSize.withPercentScaled(roundByWidth: 8), position: _pos, zPosition: 3)
        cannon.bullet.name = "1"
                            
        cannon.bullet.physicsBody = SKPhysicsBody(circleOfRadius: cannon.bullet.size.width/2)
        cannon.bullet.physicsBody?.affectedByGravity = false
        cannon.bullet.physicsBody?.isDynamic = true
        
        cannon.bullet.physicsBody?.categoryBitMask = physicDefine.bullet.rawValue
        cannon.bullet.physicsBody?.contactTestBitMask = physicDefine.line.rawValue | physicDefine.ball.rawValue
        cannon.bullet.physicsBody?.collisionBitMask = physicDefine.line.rawValue | physicDefine.ball.rawValue
        
        cannon.bullet.run(.repeatForever(.sequence([
            .scale(to: 1.1, duration: 0.5),
            .scale(to: 1, duration: 0.5)
        ])))
        addChild(cannon.bullet)
        bullets.append(cannon.bullet)
        
        cannon.dot = Sprite(imageNamed: "_target", size: CGSize.withPercentScaled(roundByWidth: 4), position: cannon.bullet.position, zPosition: 2.5)
        cannon.dot.name = "1"

        addChild(cannon.dot)
        dots.append(cannon.dot)
        
        cannon.rope = Sprite(imageNamed: "_rope_\(nameBullet).png", size: CGSize.zero, position: CGPoint.zero, zPosition: 2)
        cannon.rope.name = "1"
        
        addChild(cannon.rope)
        ropes.append(cannon.rope)
        
        cannon.back = Sprite(imageNamed: "_bullet_\(nameBullet)_b", size: .withPercentScaled(roundByWidth: 9.5), position: CGPoint.zero, zPosition: -1)
        cannon.bullet.addChild(cannon.back)
        cannon.back.run(.repeatForever(.rotate(byAngle: .pi, duration: 1)))
        cannons.append(cannon)
    }
    
    func addBall(percentRadius: CGFloat, _pos: CGPoint) {
        let randName = "_fruit_\(Int.random(in: 1...3))"
        let ball = BallObject(imageNamed: randName, size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/" + randName).size(), _sizeofNode: .withPercentScaled(roundByWidth: percentRadius)) , position: _pos, zPosition: 3)
        
        addChild(ball)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2.2)
        ball.physicsBody?.isDynamic = true
        
        ball.physicsBody?.categoryBitMask = physicDefine.ball.rawValue
        ball.physicsBody?.contactTestBitMask = physicDefine.line.rawValue | physicDefine.bullet.rawValue | physicDefine.goal.rawValue | physicDefine.wall.rawValue
        ball.physicsBody?.collisionBitMask = physicDefine.line.rawValue | physicDefine.bullet.rawValue | physicDefine.goal.rawValue | physicDefine.wall.rawValue
        
        ball.run(.repeatForever(.sequence([
            .scale(to: 1.1, duration: 0.5),
            .scale(to: 1, duration: 0.5)
        ])))
        
        balls.append(ball)
        
        targetScore += 1
    }
    
    func addGoal(_pos: CGPoint) {
        let goal = Sprite(imageNamed: "_basket", size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/_basket").size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: 15)), position: _pos, zPosition: 3)
        
        goal.position.y += 60
        addChild(goal)
        
        goal.physicsBody = SKPhysicsBody(circleOfRadius: goal.size.width/3)
        goal.physicsBody?.isDynamic = false
        
        goal.physicsBody?.categoryBitMask = physicDefine.goal.rawValue
        goal.physicsBody?.contactTestBitMask = physicDefine.ball.rawValue
        goal.physicsBody?.collisionBitMask = physicDefine.ball.rawValue
        
//        goal.run(.repeatForever(.rotate(byAngle: .pi, duration: 2)))
        goal.run(.repeatForever(.sequence([
            .scale(to: 1.2, duration: 1.5),
            .scale(to: 1, duration: 1.5)
        ])))
        goals.append(goal)
    }
    
    func addWindmill(_pos: CGPoint, percentWindmillSize: CGFloat, rotateCounterClocksise: Bool = true) {
        let windmillTexture = SKTexture(imageNamed: "Images/_windmill_1.png")
        let windmill = SKSpriteNode(texture: windmillTexture)
        
        windmill.position = _pos
        windmill.zPosition = 3
        windmill.size = sizeOfNode(_sizeOfTexture: windmillTexture.size(), _sizeofNode: CGSize.withPercentScaled(roundByHeight: percentWindmillSize))
        
        windmill.color = [#colorLiteral(red: 1, green: 0.6543407566, blue: 0.06140656701, alpha: 1),#colorLiteral(red: 1, green: 0.3277538642, blue: 0.8439162246, alpha: 1),#colorLiteral(red: 0.4393686935, green: 1, blue: 0.6376418745, alpha: 1)].randomElement() ?? #colorLiteral(red: 1, green: 0.6543407566, blue: 0.06140656701, alpha: 1)
        windmill.colorBlendFactor = 0.9
        addChild(windmill)
        
//        windmill.isHidden = true
        
        let path = CGMutablePath()
        
        let widthTexture = windmillTexture.size().width
        let w = windmill.size.width
        
        // The origin is at the center of the image.
        // The first point is on top of the image. -> -189, 449
        // Second point ->
        
        path.addLines(between: [CGPoint(x: w/widthTexture * -144, y: w/widthTexture * -186),
                                CGPoint(x: w/widthTexture * -38, y: w/widthTexture * -280),
                                CGPoint(x: w/widthTexture * 3, y: w/widthTexture * -18),
                                CGPoint(x: w/widthTexture * 11, y: w/widthTexture * -10),
                                CGPoint(x: w/widthTexture * 184, y: w/widthTexture * -142  ),
                                CGPoint(x: w/widthTexture * 280, y: w/widthTexture * -40),
                                CGPoint(x: w/widthTexture * 17, y: w/widthTexture * -4),
                                CGPoint(x: w/widthTexture * 12, y: w/widthTexture * 12),
                                CGPoint(x: w/widthTexture * 139, y: w/widthTexture * 189),
                                CGPoint(x: w/widthTexture * 39, y: w/widthTexture * 280),
                                CGPoint(x: w/widthTexture * 4, y: w/widthTexture * 17),
                                CGPoint(x: w/widthTexture * -13, y: w/widthTexture * 12),
                                CGPoint(x: w/widthTexture * -188, y: w/widthTexture * 143),
                                CGPoint(x: w/widthTexture * -278, y: w/widthTexture * 41),
                                CGPoint(x: w/widthTexture * -17, y: w/widthTexture * 4),
                                CGPoint(x: w/widthTexture * -15, y: w/widthTexture * -14)
        ])
         
        path.closeSubpath()
        windmill.physicsBody = SKPhysicsBody(polygonFrom: path)
        windmill.physicsBody?.affectedByGravity = false
        windmill.physicsBody?.isDynamic = false
        
        windmill.physicsBody?.categoryBitMask = physicDefine.line.rawValue
        windmill.physicsBody?.contactTestBitMask = physicDefine.ball.rawValue
        windmill.physicsBody?.collisionBitMask = physicDefine.ball.rawValue
        
        windmill.run(.repeatForever(.rotate(byAngle: (rotateCounterClocksise) ? .pi : (-1 * .pi), duration: 3)))
        
        
    }
    
    func addGroundAndWall() {
        let color = #colorLiteral(red: 0.7891132305, green: 0.7056680237, blue: 0.06507142203, alpha: 1) // #colorLiteral(red: 1, green: 0.4579653281, blue: 0.1485312118, alpha: 1)
        
        let ground = Sprite(imageNamed: "_zigzag", size: CGSize.withPercent(150, height: 2), position: CGPoint.withPercent(50, y: 0), zPosition: 3)
        ground.position.y += 80
        ground.color = color
        addChild(ground)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        
        ground.physicsBody?.categoryBitMask = physicDefine.wall.rawValue
        ground.physicsBody?.contactTestBitMask = physicDefine.ball.rawValue
        ground.physicsBody?.collisionBitMask = physicDefine.ball.rawValue
        
        ground.run(.repeatForever(.sequence([
            .moveBy(x: -50, y: 0, duration: 1),
            .moveBy(x: 50, y: 0, duration: 1)
        ])))
        
        let leftWall = Sprite(imageNamed: "_zigzag", size: CGSize.withPercent(250, height: 10), position: CGPoint.withPercent(-8.5, y: 50), zPosition: 3)
        
        leftWall.color = color
        leftWall.zRotation = .pi/2
        
        addChild(leftWall)
        
        leftWall.physicsBody = SKPhysicsBody(rectangleOf: leftWall.size)
        leftWall.physicsBody?.isDynamic = false
        
        leftWall.physicsBody?.categoryBitMask = physicDefine.wall.rawValue
        leftWall.physicsBody?.contactTestBitMask = physicDefine.ball.rawValue
        leftWall.physicsBody?.collisionBitMask = physicDefine.ball.rawValue
        
        leftWall.run(.repeatForever(.sequence([
            .moveBy(x: 0, y: -50, duration: 1),
            .moveBy(x: 0, y: 50, duration: 1)
        ])))
        
        let rightWall = Sprite(imageNamed: "_zigzag", size: CGSize.withPercent(250, height: 10), position: CGPoint.withPercent(108.5, y: 50), zPosition: 3)
        
        rightWall.color = color
        rightWall.zRotation = .pi/2
        
        addChild(rightWall)
        
        rightWall.physicsBody = SKPhysicsBody(rectangleOf: rightWall.size)
        rightWall.physicsBody?.isDynamic = false
        
        rightWall.physicsBody?.categoryBitMask = physicDefine.wall.rawValue
        rightWall.physicsBody?.contactTestBitMask = physicDefine.ball.rawValue
        rightWall.physicsBody?.collisionBitMask = physicDefine.ball.rawValue
        
        rightWall.run(.repeatForever(.sequence([
            .moveBy(x: 0, y: 50, duration: 1),
            .moveBy(x: 0, y: -50, duration: 1)
        ])))
    }
    
    func setLevelLbl() {
        level = UserDefaults.standard.integer(forKey: "level")
        
        toastLbl.text = "Level : \(level)"
        showToast(CGPoint.withPercent(50, y: 40))
        levelLbl.changeTextWithAnimationScaled(withText: "Level : \(level)")
//        levelLbl.attributedText = setStrokeForTextLbl(label: levelLbl)
        
        addChild([ levelLbl, toastLbl])
        Sounds.sharedInstance().playSound(soundName: "Sounds/level_up.mp3")
    }
    
    func showToast(_ pos: CGPoint) {
        toastLbl.position = pos
        toastLbl.removeAllActions()
        toastLbl.run(SKAction.sequence([SKAction.unhide(), SKAction.moveBy(x: 0, y: 100, duration: 1.0), SKAction.hide()]))
    }
    
    func addProgressbar() {
        addChild(progressBar)
        progressBar.setScale(0.22)
        progressBar.position = .withPercent(50, y: 85)
        
        progressBar.setXProgress(xProgress: progressX)
        
    }
    
    func calDistance(pos0: CGPoint, pos1: CGPoint) -> Double {
        return Double(sqrt(pow(pos1.y-pos0.y, 2) + pow(pos1.x - pos0.x, 2)))
    }
    
    func addExplodeEffect(pos : CGPoint, imageNamed: String) {
        let bombLbl = Sprite(imageNamed: imageNamed, size: CGSize.withPercentScaled(roundByHeight: 5), position: pos, zPosition: 3)
        bombLbl.run(SKAction.sequence([SKAction.scale(by: 1.5, duration: 0.3),
                                          SKAction.removeFromParent()
        ]))
        
        addChild([bombLbl])
        
        Sounds.sharedInstance().playSound(soundName: "Sounds/sound_fail.mp3")
    }
    
    func setStrokeForTextLbl(label : Label) -> NSMutableAttributedString {
        let strokeTextAttributes = [
            NSAttributedString.Key.font : UIFont(name: GameConfig.fontText, size: label.fontSize) ?? UIFont.boldSystemFont(ofSize: label.fontSize),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.blue,
            NSAttributedString.Key.strokeWidth : -4.0
            
        ] as [NSAttributedString.Key : Any]
        
        return NSMutableAttributedString(string: label.text ?? "LabelStroke", attributes: strokeTextAttributes)
    }
    
    func endlessMode() {
        setScoreLbl()
        addWindmillInEndlessMode(_pos: .withPercent(50, y: 40), percentWindmillSize: 9)
        
        if Bool.random() {
            addWindmillInEndlessMode(_pos: .withPercent(30, y: 35), percentWindmillSize: 9)
        }
        
        endlessModeRun()
        
    }
    
    func endlessModeRun() {
        
        removeAllCannon()
        
        removeAllGoal()
        removeAllLine()
        
        let linePos = CGPoint.withPercent(CGFloat.random(in: 40...60), y: CGFloat.random(in: 50...60))
        let x = self.size.width * 0.1
        let ballPos = (linePos.x > self.size.width/2 ? CGPoint(x: linePos.x - x, y: linePos.y + self.size.width * 0.07) : CGPoint(x: linePos.x + x, y: linePos.y + self.size.width * 0.07))
        let cannonPos = (linePos.x > self.size.width/2 ? CGPoint(x: linePos.x + x, y: linePos.y + self.size.width * 0.07) : CGPoint(x: linePos.x - x, y: linePos.y + self.size.height * 0.05))
        let goalPos = (linePos.x > self.size.width/2 ? CGPoint.withPercent(CGFloat.random(in: 15...25), y: CGFloat.random(in: 8...10)) : CGPoint.withPercent(CGFloat.random(in: 75...85), y: CGFloat.random(in: 8...10)))
//        let windmillPos = (linePos.x > self.size.width/2 ? CGPoint.withPercent( CGFloat.random(in: 20...30), y: CGFloat.random(in: 35...45)) : CGPoint.withPercent( CGFloat.random(in: 70...80), y: CGFloat.random(in: 35...45)))
        
        addLine(percentWidth: 35, _pos: linePos)
        addBall(percentRadius: 10, _pos: ballPos)
        addCannon(_pos: cannonPos)
        addGoal(_pos: goalPos)
        
    }
    
    func setScoreLbl() {
        
        scoreLbl.position = CGPoint.withPercent(50, y: 89)
        
        UserDefaults.standard.set(0, forKey: GameConfig.currentScore)
        score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        
        scoreLbl.changeTextWithAnimationScaled(withText: "Score: \(score) , Best: \(best)")
        scoreLbl.fontSize = 25
//        scoreLbl.attributedText = setStrokeForTextLbl(label: scoreLbl)
        
        addChild(scoreLbl)
        
    }
    
    func addWindmillInEndlessMode(_pos: CGPoint, percentWindmillSize: CGFloat, rotateCounterClocksise: Bool = true) {
        let windmillTexture = SKTexture(imageNamed: "Images/_windmill_1.png")
        let windmill = SKSpriteNode(texture: windmillTexture)
        
        windmill.position = _pos
        windmill.zPosition = 3
        windmill.size = sizeOfNode(_sizeOfTexture: windmillTexture.size(), _sizeofNode: CGSize.withPercentScaled(roundByHeight: percentWindmillSize))
        
        addChild(windmill)
        
        let path = CGMutablePath()
        
        let widthTexture = windmillTexture.size().width
        let w = windmill.size.width
        
        // The origin is at the center of the image.
        // The first point is on top of the image. -> -189, 449
        // Second point ->
        
        path.addLines(between: [CGPoint(x: w/widthTexture * -189, y: w/widthTexture * 449),
                                CGPoint(x: w/widthTexture * -321, y: w/widthTexture * 366),
                                CGPoint(x: w/widthTexture * -21, y: w/widthTexture * 0),
                                CGPoint(x: w/widthTexture * -448, y: w/widthTexture * -188),
                                CGPoint(x: w/widthTexture * -364, y: w/widthTexture * -322),
                                CGPoint(x: w/widthTexture * 0, y: w/widthTexture * -22),
                                CGPoint(x: w/widthTexture * 194, y: w/widthTexture * -447),
                                CGPoint(x: w/widthTexture * 321, y: w/widthTexture * -363),
                                CGPoint(x: w/widthTexture * 22, y: w/widthTexture * 0),
                                CGPoint(x: w/widthTexture * 450, y: w/widthTexture * 190),
                                CGPoint(x: w/widthTexture * 364, y: w/widthTexture * 322),
                                CGPoint(x: w/widthTexture * 0, y: w/widthTexture * 19)
        ])
        
        path.closeSubpath()
        windmill.physicsBody = SKPhysicsBody(polygonFrom: path)
        windmill.physicsBody?.affectedByGravity = false
        windmill.physicsBody?.isDynamic = false
        
        windmill.physicsBody?.categoryBitMask = physicDefine.line.rawValue
        windmill.physicsBody?.contactTestBitMask = physicDefine.ball.rawValue
        windmill.physicsBody?.collisionBitMask = physicDefine.ball.rawValue
        
        windmill.run(.repeatForever(.rotate(byAngle: (rotateCounterClocksise) ? .pi : (-1 * .pi), duration: 0.5)))
        
        windmill.run(.repeatForever(.sequence([
            SKAction.moveTo(x: self.size.width, duration: Double((self.size.width - windmill.position.x) / 120 )),
            SKAction.moveTo(x: 0, duration: Double(self.size.width / 120))
        ])))
        
    }
    
}
