//
//  MainMenu.swift
//  Wack-A-Pres
//
//  Created by Shanta Adhikari on 7/25/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    var playButton2 = MSButtonNode!()
    
    override func didMoveToView(view: SKView) {
        
        playButton2 = childNodeWithName("playButton2") as! MSButtonNode
        
        /* Setup restart button selection handler */
        playButton2.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = PickPres(fileNamed:"PickPres") as PickPres!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Start game scene */
            skView.presentScene(scene)
        
        }
    
    }
    
}