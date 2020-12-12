//
//  СhargObjectsTableViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 31.10.2020.
//

import UIKit

class ChargObjectsTableViewController: UITableViewController {
    
    var chargObjects = [СhargObject]()
    
    var onFinishFlow: (() -> Void)?
    var onСhargObjectSelected: ((СhargObject?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        chargObjects = DataBase.shared.getObjectsList(object: СhargObject.self) as? [СhargObject] ?? [СhargObject]()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = self.navigationController?.viewControllers.firstIndex(of: self) {
            
        }else{
            onFinishFlow?()
        }
        
    }
    
    @IBAction func addButtonPress(_ sender: Any) {
        onСhargObjectSelected?(nil)
    }
    
    func updateForm(){
        chargObjects = DataBase.shared.getObjectsList(object: СhargObject.self) as? [СhargObject] ?? [СhargObject]()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chargObjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChargObjectTableViewCell.storyBoardIdentifier, for: indexPath) as? ChargObjectTableViewCell{
            cell.setСhargObject(chargObject: chargObjects[indexPath.row])
            return cell
        }
        
        return CustomerListTableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentChargObjects = chargObjects[indexPath.row]
        onСhargObjectSelected?(currentChargObjects)
        
    }
    
}
