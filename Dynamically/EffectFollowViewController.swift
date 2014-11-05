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

    override func viewDidLoad() {
        super.viewDidLoad()

        for ball in balls() {
            ball.hidden = true
        }
        
        animator = UIDynamicAnimator(referenceView: view)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
        
        animator?.addBehavior(UIAttachmentBehavior(item: ball1!, attachedToItem: ball2!))
        animator?.addBehavior(UIAttachmentBehavior(item: ball2!, attachedToItem: ball3!))
        animator?.addBehavior(UIAttachmentBehavior(item: ball3!, attachedToItem: ball4!))
    }

    func pan(gr: UIPanGestureRecognizer) {
        if UIGestureRecognizerState.Began == gr.state {
            for ball in balls() {
                ball.hidden = false
            }
            drag = UIAttachmentBehavior(item: ball1!, attachedToAnchor: gr.locationInView(view))
            drag!.length = 20
            animator?.addBehavior(drag)
        } else if UIGestureRecognizerState.Changed == gr.state {
            drag!.anchorPoint = gr.locationInView(view)
        } else if UIGestureRecognizerState.Ended == gr.state {
            animator?.removeAllBehaviors()
            view.removeGestureRecognizer(gr)
            drop()
        }
    }
    
    func drop() {
        animator?.addBehavior(UIGravityBehavior(items: balls()))

        let collisionBehaviour = UICollisionBehavior(items: balls())
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = true;
        animator?.addBehavior(collisionBehaviour)
    }
    
    func distanceBetween(p1: CGPoint, p2: CGPoint) -> CGFloat {
        return sqrt(pow((p1.x - p2.x), 2.0) + pow((p1.y - p2.y), 2.0));
    }
    
    func balls() -> [UIView] {
        return [ball1!, ball2!, ball3!, ball4!]
    }
}
