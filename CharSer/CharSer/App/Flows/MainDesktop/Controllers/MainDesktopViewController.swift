//
//  MainDesktopViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 17.10.2020.
//

import UIKit

class MainDesktopViewController: UIViewController {

    var onMainMenu: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LeftSwipe(_ sender: Any) {
            onMainMenu?()
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
