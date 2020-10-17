//
//  User.swift
//  CharSer
//
//  Created by Андрей Закусов on 13.10.2020.
//

import Foundation

enum userRole: String {
    case admin, user
}

class User {
    var login:String = ""
    var password:String = ""
    var first_name:String = ""
    var last_name:String = ""
    
    var role: userRole = .user
    
}
