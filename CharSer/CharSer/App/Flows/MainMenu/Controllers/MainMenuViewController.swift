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
    var onChangeUser: (() -> Void)?
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
