//
//  LoginCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 14.10.2020.
//

import Foundation
import UIKit
final class LoginCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showLoginModule()
    }
    
    func startPush() {
        showLoginModulePush()
    }
    
    private func showLoginModule() {
        let controller = UIStoryboard(name: StoryboardsNames.users.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: LoginViewController.storyBoardIdentifier ) as! LoginViewController
        
        controller.onCansel = { [weak self] in
            //self?.showRecoverModule()
            self?.onFinishFlow?()
        }
        
        controller.onSuccess = { [weak self] in
             self?.onFinishFlow?()
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showLoginModulePush() {
        let controller = UIStoryboard(name: StoryboardsNames.users.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: LoginViewController.storyBoardIdentifier ) as! LoginViewController
        
        controller.onCansel = { [weak self] in
            //self?.showRecoverModule()
            self?.onFinishFlow?()
        }
        
        controller.onSuccess = { [weak self] in
             self?.onFinishFlow?()
        }
        
        self.rootController?.pushViewController(controller, animated: true)
    }
    
    
   
    
}
