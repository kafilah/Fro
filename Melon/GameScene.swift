//
//  GameScene.swift
//  Melon
//
//  Created by Kafilah on 7/6/16.
//  Copyright (c) 2016 Kafilah. All rights reserved.
//


import SpriteKit


let hairColors = [SKColor.cyanColor(),
                  SKColorWithRGB(200, g: 100, b: 10),
                  SKColor.cyanColor(),
                  SKColor.cyanColor(),
                  SKColor.cyanColor(),
                SKColor.cyanColor(),
                ]


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var hero: SKSpriteNode!
    
    var hair: SKSpriteNode!
    
    var sinceTouch : CFTimeInterval = 0
    
    var timer: CGFloat = 0
    
    var badtimer: CGFloat = 0
    
    var damagetimer: CGFloat = 0
    
    var jumptimer: CGFloat = 0
    
    var transitiontimer: CGFloat = 0
    
    var bmtimer: CGFloat = 0
    
    let hairs = ["", "fro1", "fro2", "fro3" , "fro4"]
    
    
    let levels = ["", "level1", "level2", "level3", "level4"]
    
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
    
    var level = 0
    
    
    override func didMoveToView(view: SKView) {
    /* Set up your scene here */
        
        /* Recursive node search for 'hero' (child of referenced node) */
        hero = self.childNodeWithName("//hero") as! SKSpriteNode
            
        /* Set reference to hair node which is attached to hero sprite node*/
        hair = self.childNodeWithName("//hair") as! SKSpriteNode
        
        /*sets reference to haric olors. must do same with skin*/
        hair.color = hairColors[currenthair]
        hero.texture = SKTexture(imageNamed: skinOptions[currentskin])
            
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
        
        if level > 0 {
            levelNode.removeAllChildren()
            /* Load Level 1 */
            let resourcePath = NSBundle.mainBundle().pathForResource(levels[level], ofType: "sks") /*gets and looks up current level in array*/
            let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
            levelNode.addChild(newLevel)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
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
            SKAction.moveBy(CGVector(dx: 0, dy: 50), duration: 0.5),
            SKAction.moveBy(CGVector(dx: 0, dy: -50), duration: 0.5),
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
                
                hair.xScale += 0.01
                hair.yScale += 0.002
            }
            
           
            /* deletes nodes when collide with character*/
            if nodeA.name == "goodObstacle" {
                nodeA.removeFromParent()
            }
            else {
                nodeB.removeFromParent()
            }
        }
        
        /*Code for moving bad object*/
        if (nodeA.name == "hero" || nodeB.name == "hero" ) && (nodeB.name == "badmovingObstacle" || nodeA.name == "badmovingObstacle") {
            
            /* Increment Score */
            score += 1
            
            let hair = hero.childNodeWithName("hair")!
            
            if score % 1 == 0 {
                
                hair.xScale += 0.01
                hair.yScale += 0.002
            }
            
            
            /* deletes nodes when collide with character*/
            if nodeA.name == "badmovingObstacle" {
                nodeA.removeFromParent()
            }
            else {
                nodeB.removeFromParent()
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
                score = 0
                health = 1.0
                hair.xScale = 1.0
                hair.yScale = 1.0
                hair.texture = SKTexture(imageNamed: hairs[level]) /*gets the current level and looks up which hair are we on*/
                hair.color = hairColors[level]
                
                /* only here */
                
                levelNode.removeAllChildren()
                /* Load Level 1 */
                let resourcePath = NSBundle.mainBundle().pathForResource(levels[level], ofType: "sks") /*gets and looks up current level in array*/
                let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                levelNode.addChild(newLevel)
                
            }
        }
        
        
        /* this restarts game so far if character collides with bad object*/
        if (nodeA.name == "hero" || nodeB.name == "hero" ) && (nodeB.name == "badObstacle" || nodeA.name == "badObstacle") {
            
            /*added to measure amount of contact with bad obstacle before decreasing health bar*/
            if damagetimer >= 0.5{
                
                damagetimer = 0
            
            var image: String
            if nodeA.name == "badObstacle" {
                nodeA.removeFromParent()
                image = (nodeA as! FallingObject).image
            }
            else {
                nodeB.removeFromParent()
                image = (nodeB as! FallingObject).image
                
            }
                
            /*this decrease scale of hair if it comes into contact with a bad object*/
                hair.xScale -= 0.1
                hair.yScale -= 0.02
            
            
          
            /*test for specifying a certain image*/
            
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
                self.addChild(creategoodObject(["avocado.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["gum.png"]))
                badtimer = 0}
            
            if transitiontimer > 5.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0} /*always*/
            }
        
        else if level == 1 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["banana.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 0.8 {
                self.addChild(createbadObject(["gum.png", "candle.png"]))
                badtimer = 0}
            
            if transitiontimer > 15.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
            
           /* if bmtimer > 3.0 {
                self.addChild(badmovingObject()) /*function*/
                bmtimer = 0} /*always*/ */
        }
        else if level == 2 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["banana.png", "watericon.png", "avocado.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["gum.png"]))
                badtimer = 0}
            
            if transitiontimer > 20.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 3 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["banana.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["gum.png"]))
                badtimer = 0}
            
            if transitiontimer > 30.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 4 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["banana.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject(["gum.png"]))
                badtimer = 0}
            
            if transitiontimer > 40.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        
    
        
        
        for object in self.children {
            if object.name == "goodObstacle" {
                object.position.y = object.position.y - 2
            }
            
            if object.name == "badObstacle" {
                object.position.y = object.position.y - 4
            }
            
            if object.name == "transitionObstacle" {   /*actual name of obstacle*/
                object.position.y = object.position.y - 3
                
                object.position.x += CGFloat(sin(currentTime * 2) * 3)
            }
            
            if object.name == "badmovingObstacle" {   /*actual name of obstacle*/
                object.position.y = object.position.x - 3
                
                object.position.x += CGFloat(sin(currentTime * 2) * 10)
            }
            
        }
    }

}