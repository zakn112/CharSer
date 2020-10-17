//
//  ReferenceUser.swift
//  CharSer
//
//  Created by Андрей Закусов on 11.10.2020.
//

import Foundation
import RealmSwift

class ReferenceUser: Object {
    @objc dynamic var login:String = ""
    @objc dynamic var password:String = ""
    
    @objc dynamic var first_name:String = ""
    @objc dynamic var last_name:String = ""
    
    @objc dynamic var role:String = ""
    
    
    override class func primaryKey() -> String? {
        return "login"
    }
}
