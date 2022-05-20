//
//  NewMenuScene.swift
//  B-RUNN
//
//  Created by ldmanh on 6/1/20.
//  Copyright © 2020 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene : Scene  {
    
    let swipeModeBtn = Button(normalName: "menu_btn.png", size: CGSize.zero, position: CGPoint.withPercent(30, y: 35), zPosition: GameConfig.zPosition.layer_3)
    let buttonModeBtn = Button(normalName: "menu_btn.png", size: CGSize.zero, position: CGPoint.withPercent(60, y: 65), zPosition: GameConfig.zPosition.layer_3)
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if UserDefaults.standard.integer(forKey: "maxLevel") < 1 {
            UserDefaults.standard.set(1, forKey: "maxLevel")
        }
        
//        UserDefaults.standard.set(15, forKey: "maxLevel")
        
        let ratioNormal = (swipeModeBtn.texture?.size().width ?? 500) / (swipeModeBtn.texture?.size().height ?? 500/3)
        let ratioHard = (buttonModeBtn.texture?.size().width ?? 500) / (buttonModeBtn.texture?.size().height ?? 500/3)
        let widthOfNormal: CGFloat = 35
        let widthOfHard: CGFloat = 35
        
        swipeModeBtn.size = CGSize.withPercentScaledByWidth(widthOfNormal, height: widthOfNormal/ratioNormal)
        
        buttonModeBtn.size = CGSize.withPercentScaledByWidth(widthOfHard, height: widthOfHard/ratioHard)
        
        swipeModeBtn.addChild(Label(text: "Play", fontSize: 28, fontName: GameConfig.fontText, color: GameConfig.textColor, position: .zero, zPosition: swipeModeBtn.zPosition + 0.1))
        buttonModeBtn.addChild(Label(text: "Training", fontSize: 28, fontName: GameConfig.fontText, color: GameConfig.textColor, position: .zero, zPosition: buttonModeBtn.zPosition + 0.1))
        
        addChild([backgroundSpr,  soundBtn])
        
        addChildScaleAnimation([buttonModeBtn, swipeModeBtn], duration: 0.3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if soundBtn.contains(location) {
                soundBtn.run(SKAction.scale(to: 0.85, duration: 0.025))
            }
            //Check press to switch
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            soundBtn.changeSwitchState(ifInLocation: location)
            
            if swipeModeBtn.contains(location) {
                UserDefaults.standard.set(0, forKey: GameConfig.mode)
                self.changeSceneTo(scene: LevelScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
            } else if buttonModeBtn.contains(location) {
                UserDefaults.standard.set(1, forKey: GameConfig.mode)
                self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
            }
//            if playBtn.contains(location) {
//                UserDefaults.standard.set(0, forKey: GameConfig.mode)
//                self.changeSceneTo(scene: LevelScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
//            }
            
            soundBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
        }
        
        touchUpAllButtons()
    }
}
