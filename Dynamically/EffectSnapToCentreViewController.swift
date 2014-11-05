//
//  EffectSnapToCentreViewController.swift
//  Dynamically
//
//  Created by joshua may on 5/11/2014.
//  Copyright (c) 2014 notjosh, inc. All rights reserved.
//

import UIKit

class EffectSnapToCentreViewController: UIViewController {

    @IBOutlet var centredThing: UIView?
    
    var animator: UIDynamicAnimator?
    var snap: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        snap = UISnapBehavior(item: centredThing!, snapToPoint: view.center)
        snap?.damping = 0.3
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
    }

    func pan(gr: UIPanGestureRecognizer) {
        if UIGestureRecognizerState.Began == gr.state {
            animator?.removeBehavior(snap)
        } else if UIGestureRecognizerState.Changed == gr.state {
            centredThing?.center = CGPoint(
                x: centredThing!.center.x + gr.translationInView(view).x,
                y: centredThing!.center.y + gr.translationInView(view).y
            );
            
            gr.setTranslation(CGPointZero, inView: view)
        } else if UIGestureRecognizerState.Ended == gr.state {
            animator?.addBehavior(snap)
        }
    }
}
