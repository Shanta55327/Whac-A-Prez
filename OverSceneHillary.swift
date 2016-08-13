//
//  OverSceneHillary.swift
//  Wack-A-Pres
//
//  Created by Shanta Adhikari on 8/10/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

class OverSceneHillary: SKScene {
    
    var timer: NSTimeInterval = 0
    
    var playButton: MSButtonNode!
    
    var scoreLabel: SKLabelNode!
    
    var bestScoreLabel = SKLabelNode!()
    
    var homeButton: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        
        playButton = childNodeWithName("playButton") as! MSButtonNode
        
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        bestScoreLabel = childNodeWithName("bestScoreLabel") as! SKLabelNode
        
        homeButton = childNodeWithName("homeButton") as! MSButtonNode
        
        scoreLabel.text = "\(finalGameScore)"
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        var highScore = defaults.objectForKey("High_Score")! // Retrieving your high score as a String
        
        bestScoreLabel.text = String(highScore)
        
        /* Setup restart button selection handler */
        playButton.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = HillaryScene(fileNamed:"HillaryScene") as HillaryScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Start game scene */
            skView.presentScene(scene)
            
        }
        
        homeButton.selectedHandler = {
            
            let skView = self.view as SKView!
            
            let scene = MainMenu(fileNamed:"MainMenu") as MainMenu!
            
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        self.timer += CFTimeInterval(self.speed) * (1.0 / 60.0)
        let countDownInt:Int = 2 - Int(self.timer)
        if countDownInt < 0 {
            playButton.hidden = false
        }
        
    }
    
}
