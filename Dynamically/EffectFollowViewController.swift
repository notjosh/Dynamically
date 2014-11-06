//
//  EffectFollowViewController.swift
//  Dynamically
//
//  Created by joshua may on 5/11/2014.
//  Copyright (c) 2014 notjosh, inc. All rights reserved.
//

import UIKit

class EffectFollowViewController: UIViewController {
    
    @IBOutlet var ball1: UIView?
    @IBOutlet var ball2: UIView?
    @IBOutlet var ball3: UIView?
    @IBOutlet var ball4: UIView?
    
    var animator: UIDynamicAnimator?
    var drag: UIAttachmentBehavior?
    var gravity: UIGravityBehavior?
    
    func balls() -> [UIView] {
        return [ball1!, ball2!, ball3!, ball4!]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for ball in balls() {
            ball.layer.cornerRadius = ball.bounds.width / 2
        }
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: balls())
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))

        drop()
    }

    func pan(gr: UIPanGestureRecognizer) {
        if UIGestureRecognizerState.Began == gr.state {
            animator?.removeBehavior(gravity)

            attach()

            drag = UIAttachmentBehavior(item: ball1!, attachedToAnchor: gr.locationInView(view))
            drag!.length = 0

            animator?.addBehavior(drag)
        } else if UIGestureRecognizerState.Changed == gr.state {
            drag!.anchorPoint = gr.locationInView(view)
        } else if UIGestureRecognizerState.Ended == gr.state {
            animator?.removeAllBehaviors()
            drop()
        }
    }
    
    func attach() {
        for i in 0...(balls().count - 2) {
            let a = UIAttachmentBehavior(item: balls()[i], attachedToItem: balls()[i + 1])
            a.length = balls()[i].bounds.width / 2 + balls()[i + 1].bounds.width / 2 - 1
            animator?.addBehavior(a)
        }
    }
    
    func drop() {
        animator?.addBehavior(gravity)

        let collisionBehaviour = UICollisionBehavior(items: balls())
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = true;
        animator?.addBehavior(collisionBehaviour)
    }
}
