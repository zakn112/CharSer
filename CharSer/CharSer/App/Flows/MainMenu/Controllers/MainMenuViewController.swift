//
//  MainMenuViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 17.10.2020.
//

import UIKit

class MainMenuViewController: UIViewController {

    var onMainDesktop: (() -> Void)?
    var onUsersList: (() -> Void)?
    var onCustomersList: (() -> Void)?
    var onChangeUser: (() -> Void)?
    var onСhargObjectsList: (() -> Void)?
    var onSetPricesList: (() -> Void)?
    var onCustomerOrdersList: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func LeftSwipe(_ sender: Any) {
        onMainDesktop?()
    }
    
    @IBAction func UsersListButtonPress(_ sender: Any) {
        onUsersList?()
    }
    
    @IBAction func changeUserButtonPress(_ sender: Any) {
        onChangeUser?()
    }
    
    @IBAction func customersListButtonPress(_ sender: Any) {
        onCustomersList?()
    }
    
    @IBAction func сhargObjectsListButtonPress(_ sender: Any) {
        onСhargObjectsList?()
    }
    
    @IBAction func setPricesListButtonPress(_ sender: Any) {
        onSetPricesList?()
    }
    
    @IBAction func customerOrdersListButtonPress(_ sender: Any) {
        onCustomerOrdersList?()
    }
    
    
}
