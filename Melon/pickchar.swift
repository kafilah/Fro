//
//  pickchar.swift
//  Melon
//
//  Created by Kafilah on 7/18/16.
//  Copyright © 2016 Kafilah. All rights reserved.
//

import Foundation
import SpriteKit

class pickchar: SKScene {
    
    /* UI Connections */
    var next: MSButtonNode!
    
    /*this creates UI connection for eyes*/
    var eyes: SKSpriteNode!
    
    var eyeOptions = ["eyes1", "eyes2", "eyes3", "eyes4", "eyes5"]
    
    var currenteye = 0
    
    var customizeEye: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        next = self.childNodeWithName("next") as! MSButtonNode
        
        customizeEye = self.childNodeWithName("//customizeEye") as! MSButtonNode
        
        /*this creates UI connection for eyes against*/
        eyes = self.childNodeWithName("//eyes") as! SKSpriteNode
        
        /* Setup restart button selection handler */
        next.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        /* Setup button to move through array of features that I have created */
        customizeEye.selectedHandler = {
            
            /*this enables the customize buttons to change the eye position/ color */
            self.currenteye = self.currenteye + 1
            
            /* this is module tool which counts the remainder of the array and if it is divisible by entire count sets it back to 0*/
            self.currenteye = self.currenteye % self.eyeOptions.count
            
            /* changes the texture (image) when selecting the customize button */
            self.eyes.texture = SKTexture(imageNamed: self.eyeOptions[self.currenteye])
            
            
        }
        
    }
    
}