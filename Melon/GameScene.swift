//
//  GameScene.swift
//  Melon
//
//  Created by Kafilah on 7/6/16.
//  Copyright (c) 2016 Kafilah. All rights reserved.
//


import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var hero: SKSpriteNode!
    
    var hair: SKSpriteNode!
    
    var sinceTouch : CFTimeInterval = 0
    
    var timer: CGFloat = 0
    
    var badtimer: CGFloat = 0
    
    var damagetimer: CGFloat = 0
    
    var transitiontimer: CGFloat = 0
    
    let hairs = ["", "fro1"]
    
    let levels = ["", "level1"]
    
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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            /* Get touch position in scene */
            let location = touch.locationInNode(self)
            
            hero.position.x = location.x
            
        
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            /* Get touch position in scene */
            let location = touch.locationInNode(self)
            
            
            hero.position.x = location.x
                
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
                
                levelNode.removeAllChildren()
                
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
                
                /* only here */
                
                /* Load Level 1 */
                let resourcePath = NSBundle.mainBundle().pathForResource(levels[level], ofType: "sks") /*gets and looks up current level in array*/
                let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                levelNode.addChild(newLevel)
                
            }
        }
        
        
        /* this restarts game so far if character collides with bad object*/
        if (nodeA.name == "hero" || nodeB.name == "hero" ) && (nodeB.name == "badObstacle" || nodeA.name == "badObstacle") {
            
            if nodeA.name == "badObstacle" {
                nodeA.removeFromParent()
            }
            else {
                nodeB.removeFromParent()
            }
            
            /*added to measure amount of contact with bad obstavle before decreasing health bar*/
            if damagetimer >= 0.5{
                
                damagetimer = 0
            
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
        
        /*hero.position.y = 20.793*/
        hero.physicsBody!.velocity.dy = 0
        
        
        /*make good objects fall slower*/
        if level == 0 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["avocado.png", "banana.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 1.5 {
                self.addChild(createbadObject())
                badtimer = 0}
            
            if transitiontimer > 5.0 {
                self.addChild(transitionObject()) /*function*/
                transitiontimer = 0}
        }
        else if level == 1 {
            if timer > 0.5 {
                self.addChild(creategoodObject(["banana.png", "watericon.png"]))
                timer = 0}
            
            if badtimer > 1.0 {
                self.addChild(createbadObject())
                badtimer = 0}
            
            if transitiontimer > 5.0 {
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
            }
        }
    }

}