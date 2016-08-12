//
//  GameScene.swift
//  Wack-A-Pres
//
//  Created by Shanta Adhikari on 7/12/16.
//  Copyright (c) 2016 Make School. All rights reserved.
//

import SpriteKit
import AVFoundation

/* Tracking enum for game state */
enum GameState {
    case Title, Playing, GameOver, Ready, Pause, Active
}

var lastGameScore:Int = 0

class GameScene: SKScene {
    
    /* Game management */
    var state: GameState = .Ready
    
    var mainTimer: NSTimeInterval = 0
    var score: Int = 0
    
    var timeLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var bestLabel: SKLabelNode!
    var pausedLabel: SKLabelNode!
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    var continueButton: MSButtonNode!
    var gameHomeButton: MSButtonNode!
    
    var spawnTimerTrumpHillary: CFTimeInterval = 0
    var trumps: [SKNode!] = []
    var hillarys: [SKNode!] = []
    var hammers: [SKNode!] = []
    var repBams: [SKNode!] = []
    var demBams: [SKNode!] = []
    var goldenBams: [SKNode!] = []
    var obamas: [SKNode!] = []
    var timePower10: SKNode! = nil
    var reverseTime: SKNode! = nil
    
    var spawnObama = false
    var spawntimePower10 = false
    var spawnreverseTime = false

    override func didMoveToView(view: SKView) {

        scoreLabel = childNodeWithName("//scoreLabel") as! SKLabelNode
        
        timeLabel = childNodeWithName("//timeLabel") as! SKLabelNode
        
        pausedLabel = childNodeWithName("pausedLabel") as! SKLabelNode
        
        playButton = childNodeWithName("playButton") as! MSButtonNode
        
        timePower10 = childNodeWithName("timePower10")!.children[0].childNodeWithName("timePower10")
        //spawning time powerup
        if CGFloat.random() < 0.8 {
            spawntimePower10 = true
            timePower10!.runAction(SKAction.sequence([
                SKAction.waitForDuration(NSTimeInterval(CGFloat.random(min: 10, max: 35))),
                SKAction(named: "powerups")!
                ]))
        }
        
        reverseTime = childNodeWithName("reverseTime")!.children[0].childNodeWithName("reverseTime")
        
        if CGFloat.random() < 1 {
            spawnreverseTime = true
            reverseTime!.runAction(SKAction.sequence([
                SKAction.waitForDuration(NSTimeInterval(CGFloat.random(min: 10, max: 25))),
                SKAction(named: "powerups")!
                ]))
        }
        
        gameHomeButton = childNodeWithName("gameHomeButton") as! MSButtonNode
        
        gameHomeButton.selectedHandler = {
            
            let skView = self.view as SKView!
            
            let scene = MainMenu(fileNamed:"MainMenu") as MainMenu!
            
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
            
        }
        
        continueButton = childNodeWithName("continueButton") as! MSButtonNode
        
        continueButton.selectedHandler = {
            self.state = .Playing
            self.pauseButton.hidden = false
            self.continueButton.hidden = true
            self.gameHomeButton.hidden = true
            self.pausedLabel.hidden = true
            self.paused = false
            self.physicsWorld.speed = 1
            self.runAction(SKAction.playSoundFileNamed("gameSceneMusic", waitForCompletion: false))
        }
        
        continueButton.hidden = true
        pausedLabel.hidden = true
        gameHomeButton.hidden = true
        
        pauseButton = childNodeWithName("//pauseButton") as! MSButtonNode
        
        pauseButton.selectedHandler = {
            self.pauseButton.hidden = true
            self.continueButton.hidden = false
            self.gameHomeButton.hidden = false
            self.pausedLabel.hidden = false
            self.state = .Pause
            self.paused = true
            self.physicsWorld.speed = 0
        }
        
        playButton.hidden = false
        
        /* Setup play button selection handler */
        playButton.selectedHandler = {
            
            /* Start game */
            self.state = .Ready
            
            self.playButton.hidden = true
            
            self.state = .Playing
            
            self.runAction(SKAction.playSoundFileNamed("gameSceneMusic", waitForCompletion: false))
        }
        
        for child in self.children {
            if child.name == "trump" {
                let trump = child.children[0].childNodeWithName("trump")!
                trumps.append(trump)
                trump.hidden = true
            }
        }
        
        for child in self.children {
            if child.name == "hillary" {
                let hillary = child.children[0].childNodeWithName("hillary")!
                hillarys.append(hillary)
                hillary.hidden = true
            }
        }
        
        for child in self.children {
            if child.name == "obama" {
                let obama = child.children[0].childNodeWithName("obama")!
                obamas.append(obama)
            }
        }
        
        if CGFloat.random() < 1 {
            spawnObama = true
            let index = random() % obamas.count
            obamas[index].runAction(SKAction.sequence([
                SKAction.waitForDuration(NSTimeInterval(CGFloat.random(min: 10, max: 25))),
                SKAction(named: "obamaJump")!
                ]))
        }
        
        for child in self.children {
            if child.name == "hammer" {
                hammers.append(child.children[0].childNodeWithName("hammer"))
                child.hidden = true
            }
        }
        
        for child in self.children {
            if child.name == "repBam" {
                repBams.append(child)
                child.hidden = true
            }
        }
        
        for child in self.children {
            if child.name == "demBam" {
                demBams.append(child)
                child.hidden = true
            }
        }
        
        for child in self.children {
            if child.name == "goldenBam" {
            goldenBams.append(child)
            child.hidden = true
            
            }
        }

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        /* Game not ready to play */
        if state == .GameOver { return }
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let node = self.nodeAtPoint(location)
            
            if node.name == "trump" {
                
                state == .Playing
                
                /* Increment Score */
                score += 10
                scoreLabel.text = String(score)
                
                node.removeAllActions()
                node.runAction(SKAction(named: "DropDown")!, withKey: "DropDown")
                
                var index = 0
                for t in trumps {
                    if node == t {
                        break
                    }
                    index += 1
                }
                
                hammers[index].removeAllActions()
                hammers[index].runAction(SKAction(named:"hammerHit")!, withKey: "hammerHit")
                repBams[index].removeAllActions()
                repBams[index].runAction(SKAction(named:"repBamAppear")!, withKey: "repBamAppear")
                self.runAction(SKAction.playSoundFileNamed("slap", waitForCompletion: false))
            }
            
            if node.name == "hillary" {
                
                state == .Playing
                
                /* Increment Score */
                score -= 10
                scoreLabel.text = String(score)
                
                var index = 0
                for h in hillarys {
                    if node == h {
                        break
                    }
                    index += 1
                }
                
                hammers[index].removeAllActions()
                hammers[index].runAction(SKAction(named:"hammerHit")!, withKey: "hammerHit")
                demBams[index].removeAllActions()
                demBams[index].runAction(SKAction(named:"demBamAppear")!, withKey: "demBamAppear")
                self.runAction(SKAction.playSoundFileNamed("slap", waitForCompletion: false))
            }
            
            if node.name == "obama" {
                
                score += 75
                scoreLabel.text = String(score)
                
                var index = 0
                for o in obamas {
                    if node == o {
                        break
                    }
                    index += 1
                }
                
                goldenBams[index].removeAllActions()
                goldenBams[index].runAction(SKAction(named:"goldenBam")!, withKey: "goldenBam")
                self.runAction(SKAction.playSoundFileNamed("slap", waitForCompletion: false))
            }
            
            if node.name == "timePower10" {
                
                state == .Playing
                
                mainTimer -= 10
            }
            
            if node.name == "reverseTime" {
                
                self.runAction(SKAction.sequence([
                    SKAction.speedTo(0.5, duration: 0.5),
                    SKAction.waitForDuration(5),
                    SKAction.speedTo(1.0, duration: 0.5)
                ]))
            }
            
            if node.name == "pauseButton" {
                state == .Title
            }
            
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        
        /* Called before each frame is rendered */
        if state != .Playing { return }

        mainTimer += CFTimeInterval(self.speed) * (1.0 / 60.0)
        let countDownInt:Int = 45 - Int(mainTimer)
        if countDownInt > 0 {
            timeLabel.text = "\(countDownInt)"
        }
        else {
            timeLabel.text = "0"
        }
        
        spawnTimerTrumpHillary += CFTimeInterval(self.speed) * 1/60
        
        var spawnInterval = 1.0
        if countDownInt < 25 {
            spawnInterval = 0.6
        }
        if countDownInt < 10 {
            spawnInterval = 0.40
        }
        
        
        //timer for update where after a certain amount of time, trump is updated and pops up
        if spawnTimerTrumpHillary >= spawnInterval {

            let trumpIndex = random() % trumps.count
            let trump = trumps[trumpIndex]
            let hillary = hillarys[trumpIndex]
            
            if hillary.actionForKey("jump") == nil {
                trump!.runAction(SKAction(named: "jump")!, withKey: "jump")
            }
            
            // Reset spawn timer
            spawnTimerTrumpHillary = 0
            
            let hillaryIndex = random() % hillarys.count
            
            if hillaryIndex != trumpIndex {
                let hillary = hillarys[hillaryIndex]
                let trump = trumps[hillaryIndex]
                if trump.actionForKey("jump") == nil {
                    hillary!.runAction(SKAction(named:"jump")!, withKey: "jump")
                    
                }
            }
        }

        //game ends when game is over
        if countDownInt <= 0 {
            finalScene()
        }
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        let oldHighScore = NSUserDefaults.standardUserDefaults().integerForKey("High_Score")
        
        if score > oldHighScore {
            defaults.setObject(String(score), forKey : "High_Score") // Saving the String to NSUserDefaults
        }

    }
    
    func finalScene() {
        /* Game over! */
        
        state = .GameOver
        
        playButton.hidden = false
        
        lastGameScore = score
            
        /* Grab reference to the SpriteKit view */
        let skView = self.view as SKView!
            
        /* Load Game scene */
        let scene = FinalScene(fileNamed:"FinalScene") as FinalScene!
            
        /* Ensure correct aspect mode */
        scene.scaleMode = .AspectFill
            
        /* Restart GameScene */
        skView.presentScene(scene)

    }
}
