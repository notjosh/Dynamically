//
//  EffectCollapseViewController.swift
//  Dynamically
//
//  Created by joshua may on 5/11/2014.
//  Copyright (c) 2014 notjosh, inc. All rights reserved.
//

import UIKit

class EffectCollapseViewController: UIViewController {

    var animator: UIDynamicAnimator?
    var collisionBehaviour: UICollisionBehavior?
    var gravityBehaviour: UIGravityBehavior?

    @IBOutlet var collapsible: Array<UIView> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: view)
        
        gravityBehaviour = UIGravityBehavior()
        animator?.addBehavior(gravityBehaviour)
        
        collisionBehaviour = UICollisionBehavior()
        collisionBehaviour?.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collisionBehaviour)
    }
    
    @IBAction func onoes(sender: AnyObject) {
        for sv in collapsible {
            collisionBehaviour?.addItem(sv)
            gravityBehaviour?.addItem(sv)
        }
    }
}
