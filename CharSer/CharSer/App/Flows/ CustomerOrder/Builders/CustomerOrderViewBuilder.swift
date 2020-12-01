//
//  CustomerOrderViewBuilder.swift
//  CharSer
//
//  Created by Андрей Закусов on 01.12.2020.
//

import UIKit

final class CustomerOrderViewBuilder {

    static func build() -> (UIViewController & CustomerOrderViewInput) {
        let controller = UIStoryboard(name: "CustomerOrder", bundle: nil)
            .instantiateViewController(withIdentifier: "CustomerOrder") as! CustomerOrderViewController
        
        let presenter = CustomerOrderViewPresenter()
        
        controller.presenter = presenter
        
        presenter.viewInput = controller
        
        return controller
    }
}
