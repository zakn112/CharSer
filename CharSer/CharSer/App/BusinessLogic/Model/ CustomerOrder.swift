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
    var startDate: Date = Date() {
        didSet{
            self.setDuration()
        }
    }
    var endDate: Date = Date() {
        didSet{
            self.setDuration()
        }
    }
    var amount:Double = 0
    var amountPaid:Double = 0
    var durationText: String = ""
    
    private func setDuration(){
        self.durationText = TariffCalculation.shared.durationTimeIntervalString(start: self.startDate, end: self.endDate)
    }
}

enum CustomerOrderStatus: String{
    case new, booked, inProgress, cancelled, completed
}
