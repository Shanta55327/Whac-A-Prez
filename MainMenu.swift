//
//  MainMenu.swift
//  Wack-A-Pres
//
//  Created by Shanta Adhikari on 7/25/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit
import AVFoundation

var backgroundAudio: AVAudioPlayer!

class MainMenu: SKScene {
    
    var playButton2 = MSButtonNode!()
    var creditsButton = MSButtonNode!()
    var helpButton = MSButtonNode!()
    
    override func didMoveToView(view: SKView) {
        do {
            try backgroundAudio = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Presidential", ofType: "mp3")!))
        }
        catch {
            
        }
        
        //runAction(SKAction.playSoundFileNamed("Presidential", waitForCompletion: false))
        backgroundAudio.play()
        
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
            backgroundAudio.stop()

        
        }
        
        creditsButton = childNodeWithName("creditsButton") as! MSButtonNode
        
        creditsButton.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = CreditsScene(fileNamed:"CreditsScene") as CreditsScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        helpButton = childNodeWithName("helpButton") as! MSButtonNode
        
        helpButton.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = Instructions(fileNamed:"Instructions") as Instructions!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Start game scene */
            skView.presentScene(scene)
        }
    
    }
    
}