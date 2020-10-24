//
//  MainDesktopNavigationController.swift
//  CharSer
//
//  Created by Андрей Закусов on 18.10.2020.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted: Bool = false
    var shouldFinished: Bool = false
}

class MainDesktopNavigationController: UINavigationController, UINavigationControllerDelegate {

    let pushAnimator = MainMenuPushTransitionAnimator()
    let popAnimator = MainMenuPopTransitionAnimator()
    
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
//        let edgePanGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureCatched(_:)))
//        edgePanGR.edges = .left
//        view.addGestureRecognizer(edgePanGR)
    }

    //MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            return pushAnimator
        case .pop:
            return popAnimator
        case .none:
            return nil
        @unknown default:
            fatalError()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
   
    
}


