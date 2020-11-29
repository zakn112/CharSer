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
        let controller = UIStoryboard(name: "CustomerOrder", bundle: nil)
            .instantiateViewController(withIdentifier: "CustomerOrdersList") as! CustomerOrdersTableViewController
        
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
        let controller = UIStoryboard(name: "CustomerOrder", bundle: nil)
            .instantiateViewController(withIdentifier: "CustomerOrder") as! CustomerOrderViewController
        
        controller.onSuccess = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.customerOrdersListTableViewController?.updateForm()
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
        let controller = UIStoryboard(name: "PaymentForm", bundle: nil)
            .instantiateViewController(withIdentifier: "PaymentForm") as! PaymentFormViewController
        
        let customerOrder = customerOrderViewController.thisObject
        controller.amountToBePaid = customerOrder.amount - customerOrder.amountPaid
        
        controller.onPay = { [weak self, weak customerOrderViewController] sum in
            if let sum = sum  {
                customerOrderViewController?.addPayment(sum)
            }
            self?.rootController?.popViewController(animated: true)
        }
        
        self.rootController?.pushViewController(controller, animated: true)
        
    }
    
}
