//
//  FinalScene.swift
//  Wack-A-Pres
//
//  Created by Shanta Adhikari on 8/10/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

/* Tracking enum for game state */
enum GameModes {
    case Title, Playing, GameOver, Ready, Pause, Active
}

class FinalSceneHillary: SKScene {
    
    var state: GameState = .Playing
    var score:Int = 0
    var mainTimer: NSTimeInterval = 0
    
    var finalHillary: MSButtonNode!
    var scoreLabel: SKLabelNode!
    var timeLabel: SKLabelNode!
    
    var mallet01: SKNode!
    var mallet02: SKNode!
    var malletHit = false
    
    override func didMoveToView(view: SKView) {
        
        finalHillary = childNodeWithName("finalHillary") as! MSButtonNode
        
        finalHillary.selectedHandler = {
            
            finalGameScore += 5
            self.scoreLabel.text = String(finalGameScore)
            
            if self.malletHit == true {
                self.mallet01.removeAllActions()
                self.mallet01.runAction(SKAction(named:"mallet01")!, withKey: "mallet01")
                self.malletHit = false
            }
            else {
                self.mallet02.removeAllActions()
                self.mallet02.runAction(SKAction(named:"mallet02")!, withKey: "mallet02")
                self.malletHit = true
            }
            
        }
        
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        scoreLabel.text = "\(finalGameScore)"
        
        timeLabel = childNodeWithName("timeLabel") as! SKLabelNode
        
        mallet01 = childNodeWithName("mallet01")
        
        mallet02 = childNodeWithName("mallet02")
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        /* Game not ready to play */
        if state == .GameOver { return }
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let node = self.nodeAtPoint(location)
            
            if node.name == "finalHillary" {
                
                state == .Playing
                
            }
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        /* Called before each frame is rendered */
        if state != .Playing { return }
        
        mainTimer += CFTimeInterval(self.speed) * (1.0 / 60.0)
        let countDownInt:Int = 7 - Int(mainTimer)
        if countDownInt > 0 {
            timeLabel.text = "\(countDownInt)"
        }
        else {
            timeLabel.text = "0"
        }
        
        //game ends when game is over
        if countDownInt <= 0 {
            gameOver()
        }
        
    }
    
    func gameOver() {
        
        /* Grab reference to our SpriteKit view */
        let skView = self.view as SKView!
        
        /* Load Game scene */
        let scene = OverSceneHillary(fileNamed:"OverScene") as OverSceneHillary!
        
        /* Ensure correct aspect mode */
        scene.scaleMode = .AspectFit
        
        /* Start game scene */
        skView.presentScene(scene)
        
    }
    
}