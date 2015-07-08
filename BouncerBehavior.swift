//
//  BouncerBehavior.swift
//  Bouncer
//
//  Created by Jeff Greenberg on 7/7/15.
//  Copyright (c) 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

class BouncerBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    
    lazy var collider: UICollisionBehavior = {
        let newCollider = UICollisionBehavior()
        newCollider.translatesReferenceBoundsIntoBoundary = true
        return newCollider
        }()
    
    lazy var blockBehavior: UIDynamicItemBehavior = {
        let newBehavior = UIDynamicItemBehavior()
        newBehavior.allowsRotation = true
        newBehavior.elasticity = 0.85
        newBehavior.friction = 0
        newBehavior.resistance = 0
        return newBehavior
        }()
    
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(blockBehavior)
    }
    
    func addBlock(block: UIView) {
        dynamicAnimator?.referenceView?.addSubview(block)
        collider.addItem(block)
        gravity.addItem(block)
        blockBehavior.addItem(block)
    }
    
    func removeBlock(block: UIView) {
        gravity.removeItem(block)
        collider.removeItem(block)
        blockBehavior.removeItem(block)
        block.removeFromSuperview()
    }
    
    func addBarrier(path: UIBezierPath, named name: String) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
}

