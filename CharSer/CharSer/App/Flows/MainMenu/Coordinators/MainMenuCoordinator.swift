//
//  MainMenuCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 17.10.2020.
//

import Foundation
import UIKit
final class MainMenuCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainMenuModule()
    }
    
    private func showMainMenuModule() {
        let controller = UIStoryboard(name: "mainMenu", bundle: nil)
            .instantiateViewController(withIdentifier: "mainMenu") as! MainMenuViewController
        
        controller.onMainDesktop = { [weak self] in
            self?.onFinishFlow?()
        }
        
        controller.onUsersList = { [weak self] in
           
            self?.showUserListModule()
        }
        
        controller.onChangeUser = { [weak self] in
           
            self?.showLoginModule()
        }
        
        controller.onCustomersList = { [weak self] in
           
            self?.showCustomersListModule()
        }
        
        controller.onСhargObjectsList = { [weak self] in
           
            self?.showСhargObjectsListModule()
        }
        
        
        self.rootController?.pushViewController(controller, animated: true)

    }
    
    private func showUserListModule() {
        let coordinator = UserListCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func showCustomersListModule() {
        let coordinator = CustomersListCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func showСhargObjectsListModule() {
        let coordinator = ChargObjectsListCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func showLoginModule() {
        let coordinator = LoginCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.rootController?.popViewController(animated: true)
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.startPush()
    }
    
}
