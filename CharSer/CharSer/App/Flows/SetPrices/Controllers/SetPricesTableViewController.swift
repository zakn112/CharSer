//
//  SetPricesTableViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 04.11.2020.
//

import UIKit

class SetPricesTableViewController: UITableViewController {
    var setPicesDocs: [SetPrices]?
    
    var onFinishFlow: (() -> Void)?
    var onSetPicesSelected: ((SetPrices?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        setPicesDocs = DataBase.shared.getSetPricesList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = self.navigationController?.viewControllers.firstIndex(of: self) {
            
        }else{
            onFinishFlow?()
        }

    }
    
    @IBAction func addButtonPress(_ sender: Any) {
        onSetPicesSelected?(nil)
    }

    func updateForm(){
        setPicesDocs = DataBase.shared.getSetPricesList()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return setPicesDocs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "setPricesItem", for: indexPath) as? SetPricesTableViewCell,
           let setPicesDocs = setPicesDocs {
            cell.setSetPrices(setPrices: setPicesDocs[indexPath.row])
            return cell
        }
        
        return CustomerListTableViewCell()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let setPicesDocs = setPicesDocs {
           let currentSetPicesDoc = setPicesDocs[indexPath.row]
            onSetPicesSelected?(currentSetPicesDoc)
        }
    }
  
}
