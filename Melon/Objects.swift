//
//  Obstacle.swift
//  Melon
//
//  Created by Kafilah on 7/6/16.
//  Copyright © 2016 Kafilah. All rights reserved.
//

import Foundation

import SpriteKit


     func creategoodObject() -> SKSpriteNode {
        var images = ["avocado.png", "banana.png", "watericon.png"]
        let image = images[Int(arc4random_uniform(UInt32(images.count)))] /*arcrandom fucntions recquire one more thn max*/
        
        let newgoodObstacle = SKSpriteNode(imageNamed: image)
        newgoodObstacle.physicsBody?.contactTestBitMask = 1
        newgoodObstacle.name = "goodObstacle"
        newgoodObstacle.xScale = 0.3
        newgoodObstacle.yScale = 0.4
        newgoodObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(newgoodObstacle.size.width / 2, newgoodObstacle.size.height / 2))
        newgoodObstacle.physicsBody!.affectedByGravity = false
        newgoodObstacle.position = CGPointMake(CGFloat.random(min: 10, max:300), 500)
        newgoodObstacle.physicsBody?.mass = 0.0005
        return newgoodObstacle
    }


    func createbadObject() -> SKSpriteNode {
        
        let newbadObstacle = SKSpriteNode(imageNamed: "gum.png")
        newbadObstacle.physicsBody?.contactTestBitMask = 1
        newbadObstacle.physicsBody?.contactTestBitMask = 1
        newbadObstacle.name = "badObstacle"
        newbadObstacle.xScale = 0.75
        newbadObstacle.yScale = 0.75
        newbadObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(newbadObstacle.size.width / 2, newbadObstacle.size.height / 2))
        newbadObstacle.physicsBody!.affectedByGravity = false /*changed to false so objects can manually fall*/
        newbadObstacle.position = CGPointMake(CGFloat.random(min: 10, max:300), 500)
        newbadObstacle.physicsBody?.mass = 0.005
        return newbadObstacle
        
    
    }




    

