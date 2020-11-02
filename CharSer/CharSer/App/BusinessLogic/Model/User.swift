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

class User: ReferenceModel {
    var login:String = ""
    var password:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var id: Int = 0
    
    var role: userRole = .user
    
}
