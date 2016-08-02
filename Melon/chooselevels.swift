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