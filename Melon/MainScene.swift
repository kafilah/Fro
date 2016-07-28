//
//  MainScene.swift
//  Melon
//
//  Created by Kafilah on 7/11/16.
//  Copyright © 2016 Kafilah. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    
    /* UI Connections */
    var buttonPlay: MSButtonNode!
    
    var levelButton: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonPlay = self.childNodeWithName("buttonPlay") as! MSButtonNode
        
        /*Set Ui connection to get to chooselevel page*/
        levelButton = self.childNodeWithName("levelButton") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonPlay.selectedHandler = {
            
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = pickchar(fileNamed:"pickchar") as pickchar!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        
        /*Setup chooselevels button play */
        levelButton.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Choose levels scene scene */
            let scene = chooselevels(fileNamed:"chooselevels") as chooselevels!
            
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