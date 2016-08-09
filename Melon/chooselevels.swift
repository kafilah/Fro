//
//  chooselevels.swift
//  Melon
//
//  Created by Kafilah on 7/28/16.
//  Copyright © 2016 Kafilah. All rights reserved.
//

import Foundation
import SpriteKit

class chooselevels: SKScene {
    
    /* UI Connections */
    var level0button: MSButtonNode!
    
    var level1button: MSButtonNode!
    
    var level2button: MSButtonNode!
    
    var level3button: MSButtonNode!
    
    var level4button: MSButtonNode!
    
    var level5button: MSButtonNode!
    
    var level6button: MSButtonNode!

    var level7button: MSButtonNode!
    
    var level8button: MSButtonNode!
    
    var level9button: MSButtonNode!
    
    var level10button: MSButtonNode!
    
    var level11button: MSButtonNode!
    
    var level12button: MSButtonNode!
    
    var level13button: MSButtonNode!
    
    var level14button: MSButtonNode!

    
    /*setting the functionality for the home button*/
    var home_button1: MSButtonNode!
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /*set reference to home and setting buttons*/
        home_button1 = self.childNodeWithName("//home_button1") as! MSButtonNode
        
        /* Set UI connections */
        level0button = self.childNodeWithName("level0button") as! MSButtonNode
        
        level1button = self.childNodeWithName("level1button") as! MSButtonNode
        
        level2button = self.childNodeWithName("level2button") as! MSButtonNode
        
        level3button = self.childNodeWithName("level3button") as! MSButtonNode
        
        level4button = self.childNodeWithName("level4button") as! MSButtonNode
        
        level5button = self.childNodeWithName("level5button") as! MSButtonNode
        
        level6button = self.childNodeWithName("level6button") as! MSButtonNode
        
        level7button = self.childNodeWithName("level7button") as! MSButtonNode
        
        level8button = self.childNodeWithName("level8button") as! MSButtonNode
        
        level9button = self.childNodeWithName("level9button") as! MSButtonNode
        
        level10button = self.childNodeWithName("level10button") as! MSButtonNode
        
        level11button = self.childNodeWithName("level11button") as! MSButtonNode
        
        level12button = self.childNodeWithName("level12button") as! MSButtonNode
        
        level13button = self.childNodeWithName("level13button") as! MSButtonNode
        
        level14button = self.childNodeWithName("level14button") as! MSButtonNode
        
        /* Setup button that goes to the level that is selected if clicking on the button */
        level0button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 0 /*loads the first level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level1button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 1 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level2button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 2 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level3button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 3 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level4button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 4 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level5button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 5 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level6button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 6 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level7button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 7 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level8button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 8 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level9button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 9 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level10button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 10 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level11button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 11 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level12button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 12 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        level13button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 13 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        
        level14button.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 14 /*loads the second level*/
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        
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
    }
}