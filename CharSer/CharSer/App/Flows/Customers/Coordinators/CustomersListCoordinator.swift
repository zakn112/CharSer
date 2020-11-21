//
//  CustomersListCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 27.10.2020.
//

import Foundation
import UIKit
final class CustomersListCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var customerListController: CustomersListTableViewController?
    var onFinishFlow: ((Customer?) -> Void)?
    var isSelectMode = false
    
    override func start() {
        showCustomersListModule()
    }
    
    private func showCustomersListModule() {
        let controller = UIStoryboard(name: "Customers", bundle: nil)
            .instantiateViewController(withIdentifier: "CustomersList") as! CustomersListTableViewController
        
        controller.onCustomerSelected = { [weak self] customer in
            if self?.isSelectMode == true, customer != nil  {
                self?.rootController?.popViewController(animated: true)
                self?.onFinishFlow?(customer)
            }else{
                self?.openCustomer(customer: customer)
            }
            
        }
        
        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?(nil)
        }
        
        self.customerListController = controller
        
        self.rootController?.pushViewController(controller, animated: true)
       
    }
    
    func openCustomer(customer: Customer?) {
        let controller = UIStoryboard(name: "Customers", bundle: nil)
            .instantiateViewController(withIdentifier: "Customer") as! CustomerViewController
        
        controller.onSuccess = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.customerListController?.updateForm()
        }
        controller.thisObject = customer

        self.rootController?.pushViewController(controller, animated: true)
    }
   
    
}
