//
//  Session.swift
//  CharSer
//
//  Created by Андрей Закусов on 19.09.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation
import UIKit

class Session {
    
    static let shared = Session()
    
    var currenUser: User? { didSet { saveSessionParameter("user") } }
    var firstRun = false
    
    private init() {
        if let currenUserLogin = UserDefaults.standard.string(forKey: "currenUser") {
            currenUser = DataBase.shared.getUserByLogin(login: currenUserLogin)
        }
        
    }
    
    private func saveSessionParameter(_ param: String) {
        
        if param == "user" {
            UserDefaults.standard.setValue(currenUser?.login, forKey: "currenUser")
        }
    }
}
