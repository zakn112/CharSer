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

struct VTPricesItem {
    var weekday: Int16 = 1
    var startTime: Date = Date(timeIntervalSince1970: 0)
    var endTime: Date = Date(timeIntervalSince1970: 0)
    var price: Float = 0
}
