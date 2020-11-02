//
//  CustomersListTableViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 26.10.2020.
//

import UIKit

class CustomersListTableViewController: UITableViewController {
    var customers: [Customer]?
    
    var onFinishFlow: (() -> Void)?
    var onCustomerSelected: ((Customer?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        customers = DataBase.shared.getCustomersList()

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
        customers = DataBase.shared.getCustomersList()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customers?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customerItem", for: indexPath) as? CustomerListTableViewCell,
           let customers = customers {
            cell.setCustomer(customer: customers[indexPath.row])
            return cell
        }
        
        return CustomerListTableViewCell()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let customers = customers {
           let currentCustomer = customers[indexPath.row]
            onCustomerSelected?(currentCustomer)
        }
    }

}
