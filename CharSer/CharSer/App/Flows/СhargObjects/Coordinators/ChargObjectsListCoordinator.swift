//
//  ChargObjectsListCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 31.10.2020.
//

import Foundation
import UIKit
final class ChargObjectsListCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var chargObjectsListController: ChargObjectsTableViewController?
    var onFinishFlow: ((СhargObject?) -> Void)?
    var isSelectMode = false
    
    override func start() {
        showCustomersListModule()
    }
    
    private func showCustomersListModule() {
        let controller = UIStoryboard(name: "ChargObjects", bundle: nil)
            .instantiateViewController(withIdentifier: "СhargObjectsList") as! ChargObjectsTableViewController
        
        controller.onСhargObjectSelected = { [weak self] chargObject in
            if self?.isSelectMode == true, chargObject != nil  {
                self?.rootController?.popViewController(animated: true)
                self?.onFinishFlow?(chargObject)
            }else{
                self?.openСhargObject(chargObject: chargObject)
            }
        }
        
        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?(nil)
        }
        
        self.chargObjectsListController = controller
        
        self.rootController?.pushViewController(controller, animated: true)
       
    }
    
    func openСhargObject(chargObject: СhargObject?) {
        let controller = UIStoryboard(name: "ChargObjects", bundle: nil)
            .instantiateViewController(withIdentifier: "СhargObject") as! ChargObjectsViewController
        
        controller.onSuccess = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.chargObjectsListController?.updateForm()
        }
        controller.thisObject = chargObject

        self.rootController?.pushViewController(controller, animated: true)
    }
   
    
}
