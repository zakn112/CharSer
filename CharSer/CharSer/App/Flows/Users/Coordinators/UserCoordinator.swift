//
//  UserCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 13.10.2020.
//

import Foundation
import UIKit
final class UserCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showUserModule()
    }
    
    private func showUserModule() {
        let controller = UIStoryboard(name: StoryboardsNames.users.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: UserViewController.storyBoardIdentifier ) as! UserViewController
        
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
    
   
    
}
