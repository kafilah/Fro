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
    
    /*this creates UI connection for eyes and eyecustomizebutton*/
    var eyes: SKSpriteNode!
    
    var eyeOptions = ["eyes1", "eyes2", "eyes3", "eyes4", "eyes5"]
    
    var currenteye = 0
    
    var customizeEye: MSButtonNode!
    
    /*this creates UI connection for skin and skincustomize button*/
    var skins: SKSpriteNode!
    
    var skinOptions = ["skin1", "skin2", "skin3", "skin4", "skin5", "skin6"]
    
    var currentskin = 0
    
    var customizeSkin: MSButtonNode!
    
    /*this creates UI connection for hair options*/
    var hairs: SKSpriteNode!
    
    var hairOptions = ["fro", "fro1", "fro2"]
    
    var currenthair = 0
    
    var customizeHair: MSButtonNode!
    
    /*this creates UI connection for shirt options*/
    var shirts: SKSpriteNode!
    
    var shirtOptions = ["shirt1", "shirt2", "shirt3", "shirt4", "shirt5", "shirt6"]
    
    var currentshirt = 0
    
    var customizeShirt: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        next = self.childNodeWithName("next") as! MSButtonNode
        
        /*this creates UI connection for eyes*/
        customizeEye = self.childNodeWithName("//customizeEye") as! MSButtonNode
        
        eyes = self.childNodeWithName("//eyes") as! SKSpriteNode
        
        /*this creates UI connection for skins*/
        customizeSkin = self.childNodeWithName("//customizeSkin") as! MSButtonNode
        
        skins = self.childNodeWithName("//skins") as! SKSpriteNode
        
        /*this creates UI connection for hairs*/
        customizeHair = self.childNodeWithName("//customizeHair") as! MSButtonNode
        
        hairs = self.childNodeWithName("//hairs") as! SKSpriteNode
        
        /*this creates UI connection for shirts*/
        customizeShirt = self.childNodeWithName("customizeShirt") as! MSButtonNode
        
        shirts = self.childNodeWithName("//shirts") as! SKSpriteNode
        
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
        
        /* Setup button to move through array of eyes that I have created */
        customizeEye.selectedHandler = {
            
            /*this enables the customize buttons to change the eye position/ color */
            self.currenteye = self.currenteye + 1
            
            /* this is module tool which counts the remainder of the array and if it is divisible by entire count sets it back to 0*/
            self.currenteye = self.currenteye % self.eyeOptions.count
            
            /* changes the texture (image) when selecting the customize button */
            self.eyes.texture = SKTexture(imageNamed: self.eyeOptions[self.currenteye])
            
            }
        
        
        /*Setup button to move through array of skins I have created*/
        customizeSkin.selectedHandler = {
            
            /*enables the changing of skin color*/
            self.currentskin = self.currentskin + 1
            
            /*this enables it to go back to first element in array once the skins are ran through*/
            self.currentskin = self.currentskin % self.skinOptions.count
            
            /* changes the texture of skin when clicking on customize skin button*/
            self.skins.texture = SKTexture(imageNamed: self.skinOptions[self.currentskin])
        }
        
        /*Setup button to move through array of hair objects I have created*/
        customizeHair.selectedHandler = {
            
            /*enables the changing of hair color*/
            self.currenthair = self.currenthair + 1
            
            /*this enables it to go back to change hair color*/
            self.currenthair = self.currenthair % self.hairOptions.count
            
            /* changes the texture of skin when clicking on customize hair button*/
            self.hairs.texture = SKTexture(imageNamed: self.hairOptions[self.currenthair])
        }
        
        /*Setup button to move through array of shirt objects I have created*/
        customizeShirt.selectedHandler = {
            
            /*enables the changing of shirt color*/
            self.currentshirt = self.currentshirt + 1
            
            /*this enables it to go back to change shirt color*/
            self.currentshirt = self.currentshirt % self.shirtOptions.count
            
            /*changes the texture of shirt when clicking on customize shirt button*/
            self.shirts.texture = SKTexture(imageNamed: self.shirtOptions[self.currentshirt])
        }
    }
    
}