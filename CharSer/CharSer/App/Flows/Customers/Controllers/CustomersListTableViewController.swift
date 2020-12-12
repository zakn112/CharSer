//
//  CustomersListTableViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 26.10.2020.
//

import UIKit

class CustomersListTableViewController: UITableViewController {
    var customers = [Customer]()
    
    var onFinishFlow: (() -> Void)?
    var onCustomerSelected: ((Customer?) -> Void)?
    
    var isSelectMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        customers = DataBase.shared.getObjectsList(object: Customer.self) as? [Customer] ?? [Customer]()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = self.navigationController?.viewControllers.firstIndex(of: self) {
            
        }else{
            onFinishFlow?()
        }

    }
    
    @IBAction func addButtonPress(_ sender: Any) {
        onCustomerSelected?(nil)
    }
    

    func updateForm(){
        customers = DataBase.shared.getObjectsList(object: Customer.self) as? [Customer] ?? [Customer]()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomerListTableViewCell.storyBoardIdentifier, for: indexPath) as? CustomerListTableViewCell{
            cell.setCustomer(customer: customers[indexPath.row])
            return cell
        }
        
        return CustomerListTableViewCell()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCustomer = customers[indexPath.row]
        onCustomerSelected?(currentCustomer)
    }

}
