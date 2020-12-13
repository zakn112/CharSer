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
        let controller = MainDesktopViewBuilder.build()
        
        controller.onMainMenu = { [weak self] in
            self?.showMainMenuModule()
        }
        
        controller.onNewOrder = { [weak self] chargObject in
            let customerOrder = CustomerOrder()
            customerOrder.chargObject = chargObject
            self?.showCustomerOrderModule(customerOrder)
        }

        controller.onOpenOrder = { [weak self] customerOrder in
            self?.showCustomerOrderModule(customerOrder)
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
    
    private func showCustomerOrderModule(_ customerOrder: CustomerOrder) {
        let coordinator = CustomerOrderCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start(customerOrder: customerOrder)
        
    }
    
    
    
}
