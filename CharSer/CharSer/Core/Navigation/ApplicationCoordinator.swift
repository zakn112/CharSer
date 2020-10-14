//
//  ApplicationCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 10.09.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    override func start() {
        
        Session.shared.firstRun = false
        
        if let _ = Session.shared.currenUser {
            toMain()
            return
        }
        
        let usersCount = DataBase.shared.getUsetsCount()
        
        if usersCount == 0 {
            Session.shared.firstRun = true
            addUser()
        } else{
            toLogin()
        }
    }
    
    private func toLogin() {
        let coordinator = LoginCoordinator()
       coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func addUser() {
        let coordinator = UserCoordinator()
       coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func toMain() {
        let coordinator = MainDesktopCoordinator()
       coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    

}
