//
//  MainMenuPushTransitionAnimator.swift
//  CharSer
//
//  Created by Андрей Закусов on 17.10.2020.
//

import UIKit

class MainMenuPushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from), let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        source.view.frame = transitionContext.containerView.frame
        
        let d_frame_o = destination.view.frame
        let translation = CGAffineTransform(translationX: -d_frame_o.width, y: 0 )
        
        destination.view.transform = translation
        
     
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
          
          
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.375) {
                destination.view.transform = .identity
            }
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

