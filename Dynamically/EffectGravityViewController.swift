//
//  EffectGravityViewController.swift
//  Dynamically
//
//  Created by joshua may on 5/11/2014.
//  Copyright (c) 2014 notjosh, inc. All rights reserved.
//

import UIKit

class EffectGravityViewController: UIViewController {
    
    var animator: UIDynamicAnimator?
    var collisionBehaviour: UICollisionBehavior?
    var gravityBehaviour: UIGravityBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)

//        gravityBehaviour = UIGravityBehavior()
//        animator?.addBehavior(gravityBehaviour)

//        collisionBehaviour = UICollisionBehavior()
//        collisionBehaviour?.translatesReferenceBoundsIntoBoundary = true
//        animator?.addBehavior(collisionBehaviour)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tap:"))
    }
    
    func tap(gr: UIGestureRecognizer) {
        if UIGestureRecognizerState.Ended != gr.state {
            return
        }

        let dimension: Int = Int(arc4random_uniform(40)) + 20

        let subview = UIView()
//        subview.layer.cornerRadius = CGFloat(dimension) / 2
        subview.backgroundColor = UIColor.redColor()
        subview.userInteractionEnabled = false
        subview.layer.borderColor = UIColor.blackColor().CGColor
        subview.layer.borderWidth = 1
        
//        let subview = UISwitch()
        
        subview.frame = CGRect(
            x: Int(gr.locationInView(view).x) - dimension/2,
            y: Int(gr.locationInView(view).y) - dimension/2,
            width: dimension,
            height: dimension
        )

        view.addSubview(subview)
        
        collisionBehaviour?.addItem(subview)
        gravityBehaviour?.addItem(subview)
    }
}
