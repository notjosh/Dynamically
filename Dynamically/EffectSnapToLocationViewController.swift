//
//  EffectSnapToLocationViewController.swift
//  Dynamically
//
//  Created by joshua may on 5/11/2014.
//  Copyright (c) 2014 notjosh, inc. All rights reserved.
//

import UIKit

class EffectSnapToLocationViewController: UIViewController {
    
    @IBOutlet var blob: UIView?
    
    var animator: UIDynamicAnimator?
    var snap: UISnapBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tap:"))
    }

    func tap(gr: UIGestureRecognizer) {
        if UIGestureRecognizerState.Ended != gr.state {
            return
        }

        blob?.center = gr.locationInView(view)

//        animator?.removeBehavior(snap)
//
//        snap = UISnapBehavior(
//            item: blob!,
//            snapToPoint: gr.locationInView(view)
//        )
//
//        snap?.damping = 0.2
//
//        animator?.addBehavior(snap)
    }
}
