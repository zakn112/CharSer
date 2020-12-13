//
//  CustomerOrderCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.12.2020.
//

import Foundation
import UIKit
final class CustomerOrderCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var customerOrdersListTableViewController: CustomerOrdersTableViewController?
    var onFinishFlow: (() -> Void)?
    
    func start(customerOrder: CustomerOrder?) {
        openCustomerOrder(customerOrder: customerOrder)
    }
    
    func openCustomerOrder(customerOrder: CustomerOrder?) {
        let controller = CustomerOrderViewBuilder.build()
        
        controller.onSuccess = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.customerOrdersListTableViewController?.updateForm()
            self?.onFinishFlow?()
        }
        
        controller.onSelectСhargObject = { [weak self] customerOrderViewController in
            self?.openSelectСhargObject(customerOrderViewController)
        }
        
        controller.onSelectCustomer = { [weak self] customerOrderViewController in
            self?.openSelectCustomer(customerOrderViewController)
        }
        
        controller.onPaymentForm = { [weak self] customerOrderViewController in
            self?.openPaymentForm(customerOrderViewController)
        }
        
        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?()
        }
        
        controller.thisObject = customerOrder ?? CustomerOrder()

        self.rootController?.pushViewController(controller, animated: true)
    }
    
    func openSelectСhargObject(_ customerOrderViewController: CustomerOrderViewController) {
        let coordinator = ChargObjectsListCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.isSelectMode = true
        coordinator.onFinishFlow = { [weak self, weak coordinator,  weak customerOrderViewController] chargObject  in
            customerOrderViewController?.thisObject.chargObject = chargObject
            customerOrderViewController?.updateInterface()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func openSelectCustomer(_ customerOrderViewController: CustomerOrderViewController) {
        let coordinator = CustomersListCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.isSelectMode = true
        coordinator.onFinishFlow = { [weak self, weak coordinator,  weak customerOrderViewController] customer  in
            customerOrderViewController?.thisObject.customer = customer
            customerOrderViewController?.updateInterface()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func openPaymentForm(_ customerOrderViewController: CustomerOrderViewController) {
        let controller = UIStoryboard(name: StoryboardsNames.paymentForm.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: PaymentFormViewController.storyBoardIdentifier) as! PaymentFormViewController
        
        let customerOrder = customerOrderViewController.thisObject
        controller.amountToBePaid = customerOrder.amount - customerOrder.amountPaid
        
        controller.onPay = { [weak self, weak customerOrderViewController] sum in
            if let sum = sum  {
                customerOrderViewController?.presenter.addPayment(sum)
            }
            self?.rootController?.popViewController(animated: true)
        }
        
        self.rootController?.pushViewController(controller, animated: true)
        
    }
    
}
