//
//  EffectCradleViewController.swift
//  Dynamically
//
//  Created by joshua may on 6/11/2014.
//  Copyright (c) 2014 notjosh, inc. All rights reserved.
//

import UIKit

// fairly well taken from http://www.shinobicontrols.com/blog/posts/2013/09/19/ios7-day-by-day-day-0-uikit-dynamics

class EffectCradleViewController: UIViewController {

    var balls: [UIView] = []
    
    var animator: UIDynamicAnimator?
    var push: UIPushBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: view)

        setupBalls()
//        dynamify()
    }
    
    @IBAction func boop(sender: AnyObject) {
        push = UIPushBehavior(items: [balls.first!], mode: UIPushBehaviorMode.Instantaneous)
        push?.pushDirection = CGVector(dx: -0.5, dy: 0)
        animator?.addBehavior(push)
    }
    
    func setupBalls() {
        for i in 1...5 {
//        for i in 1...10 {
            balls.append(UIView())
        }


        let size = view.bounds.width / CGFloat((3 * (balls.count - 1)))

        for (idx, b) in enumerate(balls) {
            let ball = balls[idx]
            
            ball.layer.cornerRadius = size / 2

            ball.frame = CGRect(x: 0, y: 0, width: size + 1, height: size + 1)
            ball.center = CGPoint(
                x: view.bounds.width / 3 + CGFloat(idx) * size,
                y: view.bounds.height / 2
            )

            ball.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))

            ball.backgroundColor = UIColor.redColor()
            view.addSubview(ball)
        }
    }
    
    func dynamify() {
        let behaviour = UIDynamicBehavior()
        
        for ball in balls {
            behaviour.addChildBehavior(attachmentForBall(ball))
        }
        
//        behaviour.addChildBehavior(gravityForBalls())
//        behaviour.addChildBehavior(collisionForBalls())
//        behaviour.addChildBehavior(itemForBalls())
        
        animator?.addBehavior(behaviour)
    }
    
    func attachmentForBall(ball: UIView) -> UIAttachmentBehavior {
        let anchor = CGPoint(
            x: ball.center.x,
            y: ball.center.y - view.bounds.height / 4
        )
        
        let anchorView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        anchorView.layer.cornerRadius = 5
        anchorView.backgroundColor = UIColor.blueColor()
        anchorView.center = anchor
        view.addSubview(anchorView)
        
        return UIAttachmentBehavior(item: ball, attachedToAnchor: anchor)
    }
    
    func gravityForBalls() -> UIDynamicBehavior {
        let gravity = UIGravityBehavior(items: balls)
        gravity.magnitude = 10
        return gravity
    }
    
    func collisionForBalls() -> UIDynamicBehavior {
        return UICollisionBehavior(items: balls)
    }

    func itemForBalls() -> UIDynamicBehavior {
        let item = UIDynamicItemBehavior(items: balls)
        item.elasticity = 1
        item.allowsRotation = false
        item.resistance = 2

        return item
    }

    func pan(gr: UIPanGestureRecognizer) {
        if UIGestureRecognizerState.Began == gr.state {
            animator?.removeBehavior(push)

            push = UIPushBehavior(items: [gr.view!], mode: UIPushBehaviorMode.Continuous)
            animator?.addBehavior(push)
        }
        
        push?.pushDirection = CGVector(
            dx: gr.translationInView(view).x / 10,
            dy: 0
        )
        
        if UIGestureRecognizerState.Ended == gr.state {
            // "let go" of ball
            animator?.removeBehavior(push)
            push = nil
        }
    }
}
