//
//  CustomerOrdersListCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 21.11.2020.
//

import Foundation
import UIKit
final class CustomerOrdersListCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var customerOrdersListTableViewController: CustomerOrdersTableViewController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showCustomerOrdersListModule()
    }
    
    private func showCustomerOrdersListModule() {
        let controller = UIStoryboard(name: StoryboardsNames.customerOrder.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: CustomerOrdersTableViewController.storyBoardIdentifier) as! CustomerOrdersTableViewController
        
        controller.onCustomerOrderSelected = { [weak self] customerOrder in
            self?.openCustomerOrder(customerOrder: customerOrder)
        }
        
        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?()
        }
        
        self.customerOrdersListTableViewController = controller
        
        self.rootController?.pushViewController(controller, animated: true)
       
    }
    
    func openCustomerOrder(customerOrder: CustomerOrder?) {
        
        let coordinator = CustomerOrderCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.customerOrdersListTableViewController?.updateForm()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start(customerOrder: customerOrder)
    }
       
    
}
