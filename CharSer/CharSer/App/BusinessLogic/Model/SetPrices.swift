//
//  SetPrices.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.11.2020.
//

import Foundation

class SetPrices: ReferenceModel {
    var id: Int = 0
    var date: Date = Date()
    var chargObject: СhargObject?
    var vtPrices = [VTPricesItem]()
    
}

class VTPricesItem: ReferenceModel {
    var id: Int = 0
    var strNumber: Int16 = 0
    var weekday: Int16 = 1
    var startTime: Date = Date(timeIntervalSince1970: 0)
    var endTime: Date = Date(timeIntervalSince1970: 0)
    var price: Double = 0
}
