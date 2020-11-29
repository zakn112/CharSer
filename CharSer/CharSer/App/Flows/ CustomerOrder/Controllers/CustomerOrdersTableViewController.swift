//
//  CustomerOrdersTableViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 21.11.2020.
//

import UIKit

class CustomerOrdersTableViewController: UITableViewController {
    var customerOrdersDocs: [CustomerOrder] = [CustomerOrder]()
    
    var onFinishFlow: (() -> Void)?
    var onCustomerOrderSelected: ((CustomerOrder?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        customerOrdersDocs = DataBase.shared.getObjectsList(object: CustomerOrder.self) as? [CustomerOrder] ?? [CustomerOrder]()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = self.navigationController?.viewControllers.firstIndex(of: self) {
            
        }else{
            onFinishFlow?()
        }
        
    }
    
    @IBAction func addButtonPress(_ sender: Any) {
        onCustomerOrderSelected?(nil)
    }
    
    func updateForm(){
        customerOrdersDocs = DataBase.shared.getObjectsList(object: CustomerOrder.self) as? [CustomerOrder] ?? [CustomerOrder]()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customerOrdersDocs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomerOrdersTableViewCell.cellIdentifier, for: indexPath) as? CustomerOrdersTableViewCell {
            cell.setCustomerOrder(customerOrder: customerOrdersDocs[indexPath.row])
            return cell
        }
        
        return CustomerOrdersTableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCustomerOrderDoc = customerOrdersDocs[indexPath.row]
        onCustomerOrderSelected?(currentCustomerOrderDoc)
        
    }
  
}
