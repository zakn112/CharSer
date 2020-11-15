//
//  SetPricesListCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 04.11.2020.
//

import Foundation
import UIKit
final class SetPricesListCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var setPricesTableViewController: SetPricesTableViewController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showSetPricesListModule()
    }
    
    private func showSetPricesListModule() {
        let controller = UIStoryboard(name: "SetPrices", bundle: nil)
            .instantiateViewController(withIdentifier: "SetPricesList") as! SetPricesTableViewController
        
        controller.onSetPicesSelected = { [weak self] setPrices in
            self?.openSetPrices(setPrices: setPrices)
        }
        
        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?()
        }
        
        self.setPricesTableViewController = controller
        
        self.rootController?.pushViewController(controller, animated: true)
       
    }
    
    func openSetPrices(setPrices: SetPrices?) {
        let controller = UIStoryboard(name: "SetPrices", bundle: nil)
            .instantiateViewController(withIdentifier: "SetPrices") as! SetPricesViewController
        
        controller.onSuccess = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.setPricesTableViewController?.updateForm()
        }
        
        controller.onSelectСhargObject = { [weak self] setPricesViewController in
            self?.openSelectСhargObject(setPricesViewController)
        }
        
        controller.thisObject = setPrices

        self.rootController?.pushViewController(controller, animated: true)
    }
    
    func openSelectСhargObject(_ setPricesViewController: SetPricesViewController) {
        let coordinator = ChargObjectsListCoordinator()
        
        if typeDependencyIsAdded(coordinator) {
            return
        }
        
        coordinator.rootController = rootController
        coordinator.isSelectMode = true
        coordinator.onFinishFlow = { [weak self, weak coordinator,  weak setPricesViewController] chargObject  in
            setPricesViewController?.thisObject?.chargObject = chargObject
            setPricesViewController?.updateInterface()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
   
    
}
