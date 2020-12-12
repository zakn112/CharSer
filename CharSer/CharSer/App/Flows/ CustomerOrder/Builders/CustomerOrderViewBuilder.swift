//
//  CustomerOrderViewBuilder.swift
//  CharSer
//
//  Created by Андрей Закусов on 01.12.2020.
//

import UIKit

final class CustomerOrderViewBuilder {

    static func build() -> (CustomerOrderViewController & CustomerOrderViewInput) {
        let controller = UIStoryboard(name: StoryboardsNames.customerOrder.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: CustomerOrderViewController.storyBoardIdentifier ) as! CustomerOrderViewController
        
        let presenter = CustomerOrderViewPresenter()
        
        controller.presenter = presenter
        
        presenter.viewInput = controller
        
        return controller
    }
}
