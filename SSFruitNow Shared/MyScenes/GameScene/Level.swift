//
//  Level.swift
//  ShotaSunAA iOS
//
//  Created by hehehe on 2/20/22.
//

import Foundation
import SpriteKit

extension GameScene {
    func setGameLevel() {
        switch UserDefaults.standard.integer(forKey: "level" ) {
        case 1:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(65, y: 72))
            addGoal(_pos: CGPoint.withPercent(68, y: 10))
            
            addLine(percentWidth: 30, _pos: CGPoint.withPercent(70, y: 40), zRotation: .pi * (1/12) )
            addLine(percentWidth: 30, _pos: CGPoint.withPercent(40, y: 25), zRotation: .pi * (-1 * 1/12) )
            
            addWindmill(_pos: CGPoint.withPercent(35, y: 60), percentWindmillSize: 14, rotateCounterClocksise: false)
        case 2:
            
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(15, y: 70))
            addCannon(_pos: CGPoint.withPercent(20, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(35, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(20, y: 15))
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(40, y: 24), zRotation: .pi * (1/12) )
            
            addWindmill(_pos: CGPoint.withPercent(60, y: 45), percentWindmillSize: 12)
        case 3:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(20, y: 70))
            addCannon(_pos: CGPoint.withPercent(20, y: 75))
            
            addBall(percentRadius: 10, _pos: CGPoint.withPercent(35, y: 72))
            
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(20, y: 35))
            addCannon(_pos: CGPoint.withPercent(20, y: 40))
            
            addGoal(_pos: CGPoint.withPercent(70, y: 10))
            
            addWindmill(_pos: CGPoint.withPercent(65, y: 50), percentWindmillSize: 13)
        case 4:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(40, y: 50))
            addBall(percentRadius: 10, _pos: CGPoint.withPercent(55, y: 55))
            addCannon(_pos: CGPoint.withPercent(30, y: 60))
            addGoal(_pos: CGPoint.withPercent(45, y: 10))
            addWindmill(_pos: CGPoint.withPercent(80, y: 35), percentWindmillSize: 12)
        case 5:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(15, y: 70))
            addCannon(_pos: CGPoint.withPercent(20, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(35, y: 72))
            
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(65, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(70, y: 15))
            addGoal(_pos: CGPoint.withPercent(30, y: 15))
            
            addWindmill(_pos: CGPoint.withPercent(50, y: 45), percentWindmillSize: 10)
        case 6:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(20, y: 70))
            addCannon(_pos: CGPoint.withPercent(20, y: 75))
            
            addBall(percentRadius: 10, _pos: CGPoint.withPercent(35, y: 72))
            
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(75, y: 50))
            addCannon(_pos: CGPoint.withPercent(80, y: 55))
            
            addGoal(_pos: CGPoint.withPercent(55, y: 10))
            addWindmill(_pos: CGPoint.withPercent(20, y: 30), percentWindmillSize: 13)
        case 7:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(20, y: 70))
            addCannon(_pos: CGPoint.withPercent(20, y: 75))
            
            addBall(percentRadius: 10, _pos: CGPoint.withPercent(35, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(65, y: 10))
            
            addWindmill(_pos: CGPoint.withPercent(50, y: 40), percentWindmillSize: 13)
            addWindmill(_pos: CGPoint.withPercent(78, y: 50), percentWindmillSize: 13)
            addWindmill(_pos: CGPoint.withPercent(78, y: 25), percentWindmillSize: 13)
        case 8:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(63, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(35, y: 10))
            
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(65, y: 25), zRotation: .pi * (1/12) )
            
            addWindmill(_pos: CGPoint.withPercent(40, y: 45), percentWindmillSize: 12)
        case 9:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(63, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(35, y: 10))
            
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(65, y: 50), zRotation: .pi * (1/12) )
            
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(35, y: 40), zRotation: .pi * (-1 * 1/12) )
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(35, y: 60), zRotation: .pi * (-1 * 1/12) )
            
            addWindmill(_pos: CGPoint.withPercent(60, y: 25), percentWindmillSize: 12, rotateCounterClocksise: false)
        case 10:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(63, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(35, y: 10))
            
            addWindmill(_pos: CGPoint.withPercent(40, y: 50), percentWindmillSize: 12, rotateCounterClocksise: true)
            
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(70, y: 40), zRotation: .pi * (1/12) )
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(70, y: 60), zRotation: .pi * (1/12) )
            
            addWindmill(_pos: CGPoint.withPercent(57, y: 25), percentWindmillSize: 12, rotateCounterClocksise: false)
        case 11:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(63, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(35, y: 10))
            
            addWindmill(_pos: CGPoint.withPercent(30, y: 50), percentWindmillSize: 13, rotateCounterClocksise: true)
            
            addLine(percentWidth: 15, _pos: CGPoint.withPercent(40, y: 36))
            
            addWindmill(_pos: CGPoint.withPercent(65, y: 25), percentWindmillSize: 13, rotateCounterClocksise: false)
        case 12, 14:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(63, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(60, y: 10))
            
            addWindmill(_pos: CGPoint.withPercent(20, y: 50), percentWindmillSize: 13, rotateCounterClocksise: true)
            
            addWindmill(_pos: CGPoint.withPercent(50, y: 45), percentWindmillSize: 13, rotateCounterClocksise: false)
            
            addWindmill(_pos: CGPoint.withPercent(65, y: 25), percentWindmillSize: 13, rotateCounterClocksise: false)
        case 13, 15:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(63, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(20, y: 10))
            
            addWindmill(_pos: CGPoint.withPercent(20, y: 50), percentWindmillSize: 13, rotateCounterClocksise: false)
            
            addWindmill(_pos: CGPoint.withPercent(50, y: 45), percentWindmillSize: 13, rotateCounterClocksise: true)
            
            addWindmill(_pos: CGPoint.withPercent(65, y: 25), percentWindmillSize: 13, rotateCounterClocksise: false)
        default:
            addLine(percentWidth: 50, _pos: CGPoint.withPercent(85, y: 70))
            addCannon(_pos: CGPoint.withPercent(80, y: 75))
            
            addBall(percentRadius: 8, _pos: CGPoint.withPercent(60, y: 72))
            
            addGoal(_pos: CGPoint.withPercent(65, y: 10))
            
            addWindmill(_pos: CGPoint.withPercent(40, y: 50), percentWindmillSize: 12, rotateCounterClocksise: true)
            
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(70, y: 40), zRotation: .pi * (1/12) )
            addLine(percentWidth: 25, _pos: CGPoint.withPercent(70, y: 60), zRotation: .pi * (1/12) )
            
            addWindmill(_pos: CGPoint.withPercent(57, y: 25), percentWindmillSize: 12, rotateCounterClocksise: false)
        }
        
    }
}
