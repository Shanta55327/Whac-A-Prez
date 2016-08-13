//
//  InstructionScene.swift
//  Wack-A-Pres
//
//  Created by Shanta Adhikari on 8/12/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

class Instructions: SKScene {
    
    var whiteHouse: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        
        whiteHouse = childNodeWithName("whiteHouse") as! MSButtonNode
        
        whiteHouse.selectedHandler = {
            
            let skView = self.view as SKView!
            
            let scene = MainMenu(fileNamed:"MainMenu") as MainMenu!
            
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
            
        }
    }
    
}
