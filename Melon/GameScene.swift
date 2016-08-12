//
//  GameScene.swift
//  Melon
//
//  Created by Kafilah on 7/6/16.
//  Copyright (c) 2016 Kafilah. All rights reserved.
//


import SpriteKit
import UIKit
import AVFoundation

/* Tracking enum for game state */
enum GameState {
    case Ready, Pause, Playing, GameOver, Hidden
}



let hairColors = [SKColor.cyanColor(),
                  SKColorWithRGB( 153,  g: 0, b: 76),
                  SKColorWithRGB( 0,  g: 0, b: 0),
                  SKColorWithRGB( 255,  g: 255, b: 255),
                  SKColorWithRGB( 255,  g: 204, b: 255),
                  SKColorWithRGB( 153,  g: 0, b: 76),
                  SKColorWithRGB( 153,  g: 76, b: 0),
                  SKColorWithRGB( 102,  g: 255, b: 178),
                  SKColorWithRGB( 0,  g: 204, b: 102),
                  SKColorWithRGB( 102,  g: 51, b: 0),
                  SKColorWithRGB( 51,  g: 0, b: 102),
                  SKColorWithRGB( 255,  g: 255, b: 51),
                  SKColorWithRGB( 192,  g: 192, b: 192),
                  SKColorWithRGB( 204,  g: 229, b: 255),
                ]

 var music: AVAudioPlayer!

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var hero: SKSpriteNode!
    
    var hair: SKSpriteNode!
    
    var grass:SKSpriteNode!
    
    /* Game management */
    var state: GameState = .Playing
    
    var pause_button: MSButtonNode!
    
    /*setting the functionality for the home button*/
    var home_button1: MSButtonNode!
    
    /*attempt to get frofacts to appear briefly*/
    var frofact: MSButtonNode!
    
    var sinceTouch : CFTimeInterval = 0
    
    var timer: CGFloat = 0
    
    var badtimer: CGFloat = 0
    
    var damagetimer: CGFloat = 0
    
    var jumptimer: CGFloat = 0
    
    var transitiontimer: CGFloat = 0
    
    var bmtimer: CGFloat = 0
    
    let hairs = ["fro0", "fro1", "fro2", "fro3" , "fro4" , "fro5",
                 "fro6" , "fro7" , "fro8" , "fro9" , "fro10" ,
                 "fro11" , "fro12" , "fro13" , "fro14" ]
    
    
    let levels = ["", "level1", "level2", "level3", "level4", "level5",
                  "level6", "level7", "level8", "level9", "level10",
                  "level11", "level12", "level13", "level14"]
    
    /*health bar*/
    var healthBar: SKSpriteNode!
    
    var health: CGFloat = 1.0 {
        didSet {
            /* Scale health bar between 0.0 -> 1.0 e.g 0 -> 100% */
            healthBar.xScale = health * 2.382    /*scaled relative to what i set scaled of bar too*/
        }
    }
    
    /* score label*/
    var scoreLabel: SKLabelNode!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    /* Level loader holder */
    var levelNode: SKNode!
    
    /*this sets the level intially and also loads new levels and removes grass once
    reaching a certain level*/
    var level = 0
    {
        didSet
        {
            if level > 0
            {
                levelNode.removeAllChildren()
                /* Load Level 1 */
                let resourcePath = NSBundle.mainBundle().pathForResource(levels[level], ofType: "sks") /*gets and looks up current level in array*/
                let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                levelNode.addChild(newLevel)
                frofact.texture = SKTexture(imageNamed: "frofact\(level + 1)")
                frofact.state = .MSButtonNodeStateActive
            
            hair.texture = SKTexture(imageNamed: hairs[level]) /*gets the current level and looks up which hair are we on*/
            /*this is attempt to remove grass*/
            if level > 4 && grass != nil {
                grass.removeFromParent()
            }

            } /* i moved this closing paretheses from beginning of hair.texture*/
        }
    }
    
    
    override func didMoveToView(view: SKView) {
    /* Set up your scene here */
        
        if music == nil {
            /*what plays the music file*/
            do {
                try music = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgmusic", ofType: "wav")!), fileTypeHint: nil)
            }
            catch {
            }
 
            music.numberOfLoops = -1
            music.play()
        
        }

        
        /*set reference to home and setting buttons*/
        home_button1 = self.childNodeWithName("//home_button1") as! MSButtonNode
        
        /*set reference to frofact*/
        frofact = self.childNodeWithName("//frofact") as! MSButtonNode
        
        frofact.state = .MSButtonNodeStateHidden
        
        /* Setup restart button selection handler */
        frofact.selectedHandler = {
            /*to change amount of time frofacts appear*/
            self.frofact.runAction(SKAction.fadeOutWithDuration(2.0))
            self.frofact.state = .MSButtonNodeStateHidden
        }
        
        /*sets reference to play/pause button*/
        /* UI game objects */
        pause_button = childNodeWithName("pause_button") as! MSButtonNode
        
        grass = self.childNodeWithName("//grass") as! SKSpriteNode
        
        /* Recursive node search for 'hero' (child of referenced node) */
        hero = self.childNodeWithName("//hero") as! SKSpriteNode
            
        /* Set reference to hair node which is attached to hero sprite node*/
        hair = self.childNodeWithName("//hair") as! SKSpriteNode
        
        /*sets reference to hair colors. must do same with skin*/
        hair.color = hairColors[currenthair]
        
        /*sets reference to skin colors*/
        hero.texture = SKTexture(imageNamed: skinOptions[currentskin])
        hair.texture = SKTexture(imageNamed: hairs[level]) /*gets the current level and looks up which hair are we on*/
        
        /*Set reference to healthBar node*/
        healthBar = self.childNodeWithName("//healthBar") as! SKSpriteNode
            
        /*connect the scorelabel*/
        scoreLabel = childNodeWithName("//scoreLabel") as! SKLabelNode
            
        /* Set reference to the level loader node */
        levelNode = childNodeWithName("//levelNode")
            
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        /*allows us to see whats happening in terms of phsyics in games*/
        view.showsPhysics = false /*change to true if i want too see whats happening*/
        
        /*if level <= 5{
            removeFromParent("grass")
            removeAllChildren("grass")
            /* Load Level 1 */
            let resourcePath = NSBundle.mainBundle().pathForResource(levels[level], ofType: "sks") /*gets and looks up current level in array*/
            let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
            levelNode.addChild(newLevel)
        }*/
        
        
        /*directs the player back to the homepage! lets go kfeelz!!*/
        home_button1.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = MainScene(fileNamed:"MainScene") as MainScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        pause_button.selectedHandler = {
            if self.state == .Pause
            {
                self.state = .Playing
            }
            else {
                self.state = .Pause
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        /*edits game play*/
        /* Game not ready to play */
        if state == .Pause { return }
        
        /* Game begins on first touch */
        if state == .Playing {
            state = .Pause
        }
        
        if state == .Pause {
            state = .Playing
        }
        
        /* Hide restart button .. (this is not working at the moment)*/
       /*  pause_button.state = .Hidden */
        
      
        
        for touch in touches {
            /* Get touch position in scene */
            let location = touch.locationInNode(self)
            
            hero.position.x = location.x
            
            jumptimer = 0
            
            
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            /* Get touch position in scene */
            let location = touch.locationInNode(self)
            
            
            hero.position.x = location.x
            
                
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if jumptimer < 0.5 {
        
        hero.runAction(SKAction.sequence([
            SKAction.moveBy(CGVector(dx: 0, dy: 100), duration: 0.5),
            SKAction.moveBy(CGVector(dx: 0, dy: -100), duration: 0.5),
            ]))
    }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        /* Physics contact delegate implementation */
        
        /* Get references to the bodies involved in the collision */
        let contactA:SKPhysicsBody = contact.bodyA
        let contactB:SKPhysicsBody = contact.bodyB
        
        /* Get references to the physics body parent SKSpriteNode */
        let nodeA = contactA.node as! SKSpriteNode
        let nodeB = contactB.node as! SKSpriteNode
        
        /*Check if they are colliding the obstacle and the character */
        
        if (nodeA.name == "hero" || nodeB.name == "hero" ) && (nodeB.name == "goodObstacle" || nodeA.name == "goodObstacle") {
                
            /* Increment Score */
            score += 1
            
            let hair = hero.childNodeWithName("hair")!
            
            if score % 1 == 0 {
                
                //to change hair growth amount
                
                hair.xScale += 0.07
                hair.yScale += 0.09
                
            }
           
            /* deletes nodes when collide with character*/
            var image: String
            if nodeA.name == "goodObstacle" {
                nodeA.removeFromParent()
                image = (nodeA as! FallingObject).image
            }
            else {
                nodeB.removeFromParent()
                image = (nodeB as! FallingObject).image
            }
            
            if image == "watericon.png" {
                /* Load our particle effect */
                let particles = SKEmitterNode(fileNamed: "waterEffect.sks")!
                
                /* Convert node location (currently inside Level 1, to scene space) */
                particles.position = convertPoint(hair.position, fromNode: hair)
                
                /* Restrict total particles to reduce runtime of particle */
                particles.numParticlesToEmit = 70
                
                /* Add particles to scene */
                addChild(particles)
            }
        }

        
     
        
        /*code beneath this block for transtioning into nextlevel */
        if (nodeA.name == "hero" || nodeB.name == "hero" ) && (nodeB.name == "transitionObstacle" || nodeA.name == "transitionObstacle") {
            
            /*checks collisions so it doesnt go the next level more than once*/
            if damagetimer >= 0.5{
                
                damagetimer = 0
            
                if nodeA.name == "transitionObstacle" {
                    nodeA.removeFromParent()
                }
                else {
                    nodeB.removeFromParent()
                }
                
                
                level += 1
              
                
                /*test to remove all existing obstacles*/
                for object in self.children {
                    if object.name == "goodObstacle" || object.name == "badObstacle" {
                        object.removeFromParent()
                    }
                }
                
                /* to reset the score and health bar i added this code*/
                // only need this if i want to reset score code [score = 0] //
                health = 1.0
                hair.xScale = 1.0
                hair.yScale = 1.0
                
                
                
                /* only here */
                
                levelNode.removeAllChildren()
                /* Load Level 1 */
                let resourcePath = NSBundle.mainBundle().pathForResource(levels[level], ofType: "sks") /*gets and looks up current level in array*/
                let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                levelNode.addChild(newLevel)
                
                /*inserting to check and make sure the grass is removed again*/
                if level > 4 && grass != nil {
                    grass.removeFromParent()
                }
                
            }
        }
        
        
        /* this restarts game so far if character collides with bad object*/
        if (nodeA.name == "hero" || nodeB.name == "hero" ) && (nodeB.name == "badObstacle" || nodeA.name == "badObstacle" || nodeB.name == "badmovingObstacle" || nodeA.name == "badmovingObstacle") {
            
            /*added to measure amount of contact with bad obstacle before decreasing health bar*/
            if damagetimer >= 0.5{
                
                damagetimer = 0
            
            var image: String
            if nodeA.name == "badObstacle" || nodeA.name == "badmovingObstacle" {
                nodeA.removeFromParent()
                image = (nodeA as! FallingObject).image
            }
            else {
                nodeB.removeFromParent()
                image = (nodeB as! FallingObject).image
                }
            
                
            /*this decrease scale of hair if it comes into contact with a bad object*/
               // hair.xScale -= 0.03
               // hair.yScale -= 0.08
                
                hair.xScale -= 0.07
                hair.yScale -= 0.09
            
            
          
            /*test for specifying a certain image and adding an effect*/
            
            if image == "candle.png" {
                /* Load our particle effect */
                let particles = SKEmitterNode(fileNamed: "candleExplosion")!
                
                /* Convert node location (currently inside Level 1, to scene space) */
                particles.position = convertPoint(hair.position, fromNode: hair)
                
                /* Restrict total particles to reduce runtime of particle */
                particles.numParticlesToEmit = 50
                
                /* Add particles to scene */
                addChild(particles)
            }
         
                if image == "heatrays.png" {
                    /* Load our particle effect */
                    let particles = SKEmitterNode(fileNamed: "heatEffect")!
                    
                    /* Convert node location (currently inside Level 1, to scene space) */
                    particles.position = convertPoint(hair.position, fromNode: hair)
                    
                    /* Restrict total particles to reduce runtime of particle */
                    particles.numParticlesToEmit = 100
                    
                    /* Add particles to scene */
                    addChild(particles)
                    
                }
                
                if image == "alcohol.png" {
                    /* Load our particle effect */
                    let particles = SKEmitterNode(fileNamed: "alcoholReaction")!
                    
                    /* Convert node location (currently inside Level 1, to scene space) */
                    particles.position = convertPoint(hair.position, fromNode: hair)
                    
                    /* Restrict total particles to reduce runtime of particle */
                    particles.numParticlesToEmit = 100
                    
                    /* Add particles to scene */
                    addChild(particles)
                }
                
                if image == "relaxertub.png" {
                    /* Load our particle effect */
                    let particles = SKEmitterNode(fileNamed: "alcoholReaction")!
                    
                    /* Convert node location (currently inside Level 1, to scene space) */
                    particles.position = convertPoint(hair.position, fromNode: hair)
                    
                    /* Restrict total particles to reduce runtime of particle */
                    particles.numParticlesToEmit = 100
                    
                    /* Add particles to scene */
                    addChild(particles)
                }

                
                if image == "flatiron.png" {
                    /* Load our particle effect */
                    let particles = SKEmitterNode(fileNamed: "alcoholReaction")!
                    
                    /* Convert node location (currently inside Level 1, to scene space) */
                    particles.position = convertPoint(hair.position, fromNode: hair)
                    
                    /* Restrict total particles to reduce runtime of particle */
                    particles.numParticlesToEmit = 100
                    
                    /* Add particles to scene */
                    addChild(particles)
                
            }
                
                
                /*decrease health*/
                health -= 0.1
                
                if health <= 0 {
                
                    /* Grab reference to our SpriteKit view */
                    if let skView = self.view as SKView! {
                    
                        /* Load Game scene */
                        let scene = MainScene(fileNamed:"MainScene") as MainScene!
                        
                        /* Ensure correct aspect mode */
                        scene.scaleMode = .AspectFill
                        
                        /* Start game scene */
                    skView.presentScene(scene)
                    }
                }
            }
        }
    
    }
    
    override func update(currentTime: CFTimeInterval) {
        if self.state == .Pause {return}
        timer += 1.0 / 60.0
        badtimer += 1.0 / 60.0
        damagetimer += 1.0 / 60.0
        transitiontimer += 1.0 / 60.0
        jumptimer += 1.0/60.0
        bmtimer += 1.0/60.0
        
        /*hero.position.y = 20.793*/
        hero.physicsBody!.velocity.dy = 0 /*just edited this*/
        
        
        /*make good objects fall slower*/
        /*also edit stuff for levels*/
        if level == 0 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "watericon.png", ]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png"]))
                badtimer = 0}
            
            if transitiontimer > 30.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0} /*always*/
            }
        
        else if level == 1 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 0.8 {
                self.addChild(createbadObject(["heatrays.png", "candle.png"]))
                badtimer = 0}
            
            if transitiontimer > 15.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
            
            /*test code for blowdryer obstacle*/
            if bmtimer > 3.0 {
                self.addChild(badmovingObject()) /*function*/
                bmtimer = 0} /*always*/
            }
        else if level == 2 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png"]))
                badtimer = 0}
            
            if transitiontimer > 20.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 3 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png"]))
                badtimer = 0}
            
            if transitiontimer > 30.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 4 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 5 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 6 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 7 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 8 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 9 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png", "honey.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png", "relaxertub.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 10 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png", "honey.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png", "relaxertub.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 11 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png", "honey.png", "leafy.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png", "relaxertub.png", "flatiron.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 12 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png", "honey.png", "leafy.png", "oliveoil.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png", "relaxertub.png", "flatiron.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 13 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png", "honey.png", "leafy.png", "oliveoil.png", "eggs.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png", "relaxertub.png", "flatiron.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 14 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png", "coconutoil.png", "conditioner.png", "shampoo.png", "honey.png", "leafy.png", "oliveoil.png", "eggs.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["heatrays.png", "candle.png", "alcohol.png", "permbox.png", "petroleum.png", "relaxertub.png", "flatiron.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        
        
    
        
        
        for object in self.children {
            if object.name == "goodObstacle" {
                object.position.y = object.position.y - 2 - CGFloat(level) * 0.5 /*controls speed of objects by level*/
            }
            
            if object.name == "badObstacle" {
                object.position.y = object.position.y - 4
            }
            
            if object.name == "transitionObstacle" {   /*actual name of obstacle*/
                object.position.y = object.position.y - 1.5
                
                object.position.x += CGFloat(sin(currentTime * 2) * 3)
            }
        
            
        }
    }

}