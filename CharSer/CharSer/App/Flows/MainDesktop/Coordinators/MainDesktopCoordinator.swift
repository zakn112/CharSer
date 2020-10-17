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
            .instantiateViewController(withIdentifier: "mainDesktop")
        
//        controller.onCansel = { [weak self] in
//            //self?.showRecoverModule()
//            self?.onFinishFlow?()
//        }
//
//        controller.onSuccess = { [weak self] in
//             self?.onFinishFlow?()
//        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
   
    
}
