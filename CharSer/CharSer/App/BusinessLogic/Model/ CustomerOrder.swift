//
//   CustomerOrder.swift
//  CharSer
//
//  Created by Андрей Закусов on 15.11.2020.
//

import Foundation

class CustomerOrder: ReferenceModel {
    var id: Int = 0
    var date: Date = Date()
    var chargObject: СhargObject?
    var status: CustomerOrderStatus = .new
    var customer: Customer?
    var author: User?
    var startDate: Date = Date()
    var endDate: Date = Date()
    var amount:Double = 0
    var amountPaid:Double = 0
    
}

enum CustomerOrderStatus: String{
    case new, booked, inProgress, cancelled, completed
}
