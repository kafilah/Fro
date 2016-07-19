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
    
    /* score label*/
    var scoreLabel: SKLabelNode!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    override func didMoveToView(view: SKView) {
    /* Set up your scene here */
        
    /* Recursive node search for 'hero' (child of referenced node) */
    hero = self.childNodeWithName("//hero") as! SKSpriteNode
        
    /* Set reference to hair node which is attached to hero sprite node*/
    hair = self.childNodeWithName("//hair") as! SKSpriteNode

        
    /*connect the scorelabel*/
    scoreLabel = childNodeWithName("//scoreLabel") as! SKLabelNode
        
    /* Set physics contact delegate */
    physicsWorld.contactDelegate = self
        
        /*allows us to see whats happening in terms of phsyics in games*/
        view.showsPhysics = false /*change to true if i want too see whats happening*/

        self.addChild(creategoodObject())
        self.addChild(createbadObject())
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
        
        
        
        /* this restarts game so far if character collides with bad object*/
        if (nodeA.name == "hero" || nodeB.name == "hero" ) && (nodeB.name == "badObstacle" || nodeA.name == "badObstacle") {
            
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
    
    override func update(currentTime: CFTimeInterval) {
        timer += 1.0 / 60.0
        badtimer += 1.0 / 60.0
        
        /*hero.position.y = 20.793*/
        hero.physicsBody!.velocity.dy = 0
        
        
        /*make good objects fall slower*/
        if timer > 0.5 {
            self.addChild(creategoodObject())
            timer = 0}
        
        if badtimer > 1.5 {
            self.addChild(createbadObject())
            badtimer = 0}
        
        
        for object in self.children {
            if object.name == "goodObstacle" {
                object.position.y = object.position.y - 2
            }
            
            if object.name == "badObstacle" {
                object.position.y = object.position.y - 4
            }
        }
        
        
        
        
        
        
        
        /* Called before each frame is rendered */
        
        
        }
    }
