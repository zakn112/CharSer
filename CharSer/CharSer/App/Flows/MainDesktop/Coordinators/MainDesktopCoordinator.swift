//
//  MainDesktopCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 14.10.2020.
//

import Foundation
import UIKit
final class MainDesktopCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainDesktop()
    }
    
    private func showMainDesktop() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "mainDesktop") as! MainDesktopViewController
        
        controller.onMainMenu = { [weak self] in
            self?.showMainMenuModule()
        }
        
        let rootController = MainDesktopNavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showMainMenuModule() {
        let coordinator = MainMenuCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        coordinator.rootController = rootController
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.rootController?.popViewController(animated: true)
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    
    
}
