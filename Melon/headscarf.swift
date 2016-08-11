//
//  headscarf.swift
//  Melon
//
//  Created by Kafilah on 8/10/16.
//  Copyright © 2016 Kafilah. All rights reserved.
//


import SpriteKit
import UIKit

//for a future version i will remove this once viewed
//by creating a bool function that states if it is 
//seen already then dissappear but if not then keep it
//but as of now i think it is important for user

class headscarf: SKScene {
    
    /* UI Connections */
    var next: MSButtonNode!
    
    /*setting the functionality for the home button*/
    var home_button1: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /*set reference to home and setting buttons*/
        home_button1 = self.childNodeWithName("//home_button1") as! MSButtonNode
        
        /* Set UI connections */
        next = self.childNodeWithName("next") as! MSButtonNode
        
        /* Setup restart button selection handler */
        next.selectedHandler = {
            
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = pickchar(fileNamed:"pickchar") as pickchar!
            
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
