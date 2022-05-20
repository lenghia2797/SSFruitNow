//
//  IMProgressBar.swift
//  TurnBase
//
//  Created by Mr. Joker on 7/17/19.
//  Copyright © 2019 Viet Nguyen. All rights reserved.
//

import Foundation
import SpriteKit


class IMProgressBar : SKNode{
    
    var emptySprite : SKSpriteNode? = nil
    var progressBar : SKCropNode
    
    init(emptyImageName: String!,filledImageName : String)
    {
        progressBar = SKCropNode()
        super.init()
        let filledImage  = SKSpriteNode(imageNamed: "Images/" + filledImageName)
        progressBar.addChild(filledImage)
        progressBar.maskNode = SKSpriteNode(color: UIColor.red,
                                            size: CGSize(width: filledImage.size.width * 2, height: filledImage.size.height * 2))
        
        progressBar.maskNode?.position = CGPoint(x: -filledImage.size.width / 2,y: -filledImage.size.height / 2)
        progressBar.zPosition = 0.1
        self.addChild(progressBar)
        
        if emptyImageName != nil{
            emptySprite = SKSpriteNode.init(imageNamed: "Images/" + emptyImageName)
            self.addChild(emptySprite!)
        }
    }
    func setXProgress(xProgress : CGFloat){
        var value = xProgress
        if xProgress < 0{
            value = 0
        }
        if xProgress > 1 {
            value = 1
        }
        progressBar.maskNode?.xScale = value
    }
    
    func setYProgress(yProgress : CGFloat){
        var value = yProgress
        if yProgress < 0{
            value = 0
        }
        if yProgress > 1 {
            value = 1
        }
        progressBar.maskNode?.yScale = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
