//
//  ReferenceСustomer.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.10.2020.
//

import Foundation
import RealmSwift

class ReferenceСustomer: Object {
    @objc dynamic var customer_ID:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var phone:String = ""
    
    override class func primaryKey() -> String? {
        return "customer_ID"
    }
}
