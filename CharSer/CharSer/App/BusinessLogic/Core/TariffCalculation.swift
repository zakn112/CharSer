//
//  TariffCalculation.swift
//  CharSer
//
//  Created by Андрей Закусов on 22.11.2020.
//

import Foundation

class TariffCalculation {
    static let shared = TariffCalculation()
    
    func durationTimeIntervalString(start: Date, end: Date) -> (String) {
        
        guard end > start else {
            return ""
        }
        
        let interval = end.timeIntervalSince(start)
        
        let days = Int(interval / (24 * 60 * 60))
        let hours = Int((interval - Double(days * 24 * 60 * 60)) / (60 * 60))
        let minutes = Int((interval - Double(days * 24 * 60 * 60) - Double(hours * 60 * 60)) / 60)
        
        var intervalDiscription = ""
        if days > 0 {
            intervalDiscription += "\(days) дн. "
        }
        
        if hours > 0 {
            intervalDiscription += "\(hours) ч. "
        }
        
        if minutes > 0 {
            intervalDiscription += "\(minutes) мин."
        }
        
        return intervalDiscription
    }
    
    func ammuntTimeInterval(start: Date, end: Date) -> (Double) {
        
//        let calendar = Calendar.current
//        
//        let setPrices = DataBase.shared.getSetPricesLast()
//        
//        start
        
        return 10
    }
}
