//
//  ReferenceСhargObject.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.10.2020.
//

import Foundation
import RealmSwift

class ReferenceСhargObject: Object {
    @objc dynamic var chargObject_ID:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var startTime:Date = Date()
    @objc dynamic var shutdownTime:Date = Date()
    
    override class func primaryKey() -> String? {
        return "chargObject_ID"
    }
}
