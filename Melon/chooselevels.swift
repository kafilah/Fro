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
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        level0button = self.childNodeWithName("level0button") as! MSButtonNode
        
        level1button = self.childNodeWithName("level1button") as! MSButtonNode
        
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
            
            /* Show debug */
            skView.showsDrawCount = true
            skView.showsFPS = true
            
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
            
            /* Show debug */
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
     
    }
}