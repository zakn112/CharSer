//
//  DocumentCustomerOrder.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.10.2020.
//

import Foundation
import RealmSwift

class DocumentCustomerOrder: Object {
    @objc dynamic var customerOrderID:Int = 0
    @objc dynamic var date:Date = Date()
    @objc dynamic var number:String = ""
    @objc dynamic var chargObjectID:Int = 0
    @objc dynamic var status:String = ""
    @objc dynamic var customerID:Int = 0
    @objc dynamic var author:Int = 0
    @objc dynamic var startTime:Date = Date()
    @objc dynamic var endTime:Date = Date()
    @objc dynamic var amountTime:Double = 0
    @objc dynamic var amountPaid:Double = 0
    @objc dynamic var sessionDuration:Double = 0
    
    override class func primaryKey() -> String? {
        return "customerOrderID"
    }
}
