//
//  UserListCoordinator.swift
//  CharSer
//
//  Created by Андрей Закусов on 19.10.2020.
//

import Foundation
import UIKit
final class UserListCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var userListController: UsersListTableViewController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showUserListModule()
    }
    
    private func showUserListModule() {
        let controller = UIStoryboard(name: StoryboardsNames.users.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: UsersListTableViewController.storyBoardIdentifier) as! UsersListTableViewController
        
        controller.onUserSelected = { [weak self] user in
            self?.openUser(user: user)
        }
        
        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?()
        }
        
        self.userListController = controller
        
        self.rootController?.pushViewController(controller, animated: true)
       
    }
    
    func openUser(user: User?) {
        let controller = UIStoryboard(name: StoryboardsNames.users.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: UserViewController.storyBoardIdentifier) as! UserViewController
        
        controller.onSuccess = { [weak self] in
            self?.rootController?.popViewController(animated: true)
            self?.userListController?.updateForm()
        }
        controller.user = user

        self.rootController?.pushViewController(controller, animated: true)
    }
   
    
}
