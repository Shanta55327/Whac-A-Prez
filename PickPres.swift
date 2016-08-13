//
//  PickPres.swift
//  Wack-A-Pres
//
//  Created by Shanta Adhikari on 7/25/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

class PickPres: SKScene {
    
    var hillaryPodium: MSButtonNode!
    
    var trumpPodium: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        
        hillaryPodium = childNodeWithName("hillaryPodium") as! MSButtonNode
        
        trumpPodium = childNodeWithName("trumpPodium") as! MSButtonNode
        
        /* Setup restart button selection handler */
        trumpPodium.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        /* Setup restart button selection handler */
        hillaryPodium.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = HillaryScene(fileNamed:"HillaryScene") as HillaryScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Start game scene */
            skView.presentScene(scene)
        }
    
    }
    
}

