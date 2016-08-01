//
//  pickchar.swift
//  Melon
//
//  Created by Kafilah on 7/18/16.
//  Copyright © 2016 Kafilah. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

var currentskin = 0
var currenthair = 0

var skinOptions = ["skin1", "skin2", "skin3", "skin4", "skin5", "skin6"]

class pickchar: SKScene {
    
    /* UI Connections */
    var next: MSButtonNode!
    
    
    
    /*this creates UI connection for skin and skincustomize button*/
    var skins: SKSpriteNode!
    
    
    var customizeSkin: MSButtonNode!
    
    /*this creates UI connection for hair options*/
    var hairs: SKSpriteNode!
    
    
    var customizeHair: MSButtonNode!
    
   
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        next = self.childNodeWithName("next") as! MSButtonNode
        
        
        /*this creates UI connection for skins*/
        customizeSkin = self.childNodeWithName("//customizeSkin") as! MSButtonNode
        
        skins = self.childNodeWithName("//skins") as! SKSpriteNode
        
        /*this creates UI connection for hairs*/
        customizeHair = self.childNodeWithName("//customizeHair") as! MSButtonNode
        
        hairs = self.childNodeWithName("//hairs") as! SKSpriteNode
        
        hairs.color = hairColors[currenthair]
        skins.texture = SKTexture(imageNamed: skinOptions[currentskin])
        
        /* Setup restart button selection handler */
        next.selectedHandler = {
            
            /*copy this to create it to go back to main scene when objects are colliding*/
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.level = 0
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        
        /*Setup button to move through array of skins I have created*/
        customizeSkin.selectedHandler = {
            
            /*enables the changing of skin color*/
            currentskin = currentskin + 1
            
            /*this enables it to go back to first element in array once the skins are ran through*/
            currentskin = currentskin % skinOptions.count
            
            /* changes the texture of skin when clicking on customize skin button*/
            self.skins.texture = SKTexture(imageNamed: skinOptions[currentskin])
        }
        
        
        /*Setup button to move through array of hair objects I have created*/
        customizeHair.selectedHandler = {
            
            /*enables the changing of hair color*/
            currenthair = currenthair + 1
            
            /*this enables it to go back to change hair color*/
            currenthair = currenthair % hairColors.count
            
            /* changes the texture of skin when clicking on customize hair button*/
            self.hairs.color = hairColors[currenthair]
        }
        self.hairs.color = hairColors[currenthair]
    }
}