//
//  Obstacle.swift
//  Melon
//
//  Created by Kafilah on 7/6/16.
//  Copyright © 2016 Kafilah. All rights reserved.
//

import Foundation
import SpriteKit

class FallingObject : SKSpriteNode {
    var image: String = ""
}


    func creategoodObject(images: [String]) -> SKSpriteNode {
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


func createbadObject(images: [String]) -> SKSpriteNode {
    
        /* i did the same thing as the good object because i am calling the actual objects in the gamescene swift */ 
        let image = images[Int(arc4random_uniform(UInt32(images.count)))] /*arcrandom fucntions recquire one more thn max*/
    
        let newbadObstacle = FallingObject(imageNamed: image)
        newbadObstacle.image = image
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

    func transitionObject () -> SKSpriteNode {
    
    let newtransitionObstacle = SKSpriteNode(imageNamed: "silkscarf.png")
    newtransitionObstacle.physicsBody?.contactTestBitMask = 1
    newtransitionObstacle.physicsBody?.contactTestBitMask = 1
    newtransitionObstacle.name = "transitionObstacle"
    newtransitionObstacle.xScale = 0.75
    newtransitionObstacle.yScale = 0.75
    newtransitionObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(newtransitionObstacle.size.width / 2, newtransitionObstacle.size.height / 2))
    newtransitionObstacle.physicsBody!.affectedByGravity = false /*changed to false so objects can manually fall*/
    newtransitionObstacle.position = CGPointMake(CGFloat.random(min: 10, max:300), 500)
    newtransitionObstacle.physicsBody?.mass = 0.005
    return newtransitionObstacle
}














