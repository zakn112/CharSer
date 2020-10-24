//
//  UsersListTableViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 18.10.2020.
//

import UIKit

class UsersListTableViewController: UITableViewController {
    
    var users: [User]?
    
    var onFinishFlow: (() -> Void)?
    var onUserSelected: ((User?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        users = DataBase.shared.getUsersList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = self.navigationController?.viewControllers.firstIndex(of: self) {
            
        }else{
            onFinishFlow?()
        }

    }
    
    @IBAction func addUserButtonPress(_ sender: Any) {
        onUserSelected?(nil)
    }
    
    func updateForm(){
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users?.count ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userItem", for: indexPath) as? UsersListTableViewCell,
           let users = users {
            cell.setUser(user: users[indexPath.row])
            return cell
        }
        
        return UsersListTableViewCell()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let users = users {
           let currentUser = users[indexPath.row]
            onUserSelected?(currentUser)
        }
    }
    
    

}
