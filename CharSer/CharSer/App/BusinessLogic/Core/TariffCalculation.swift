//
//  TariffCalculation.swift
//  CharSer
//
//  Created by Андрей Закусов on 22.11.2020.
//

import Foundation

class TariffCalculation {
    static let shared = TariffCalculation()
    var calendar = Calendar.current//Calendar(identifier: .gregorian)
    
    init() {
//        calendar.timeZone = TimeZone.init(identifier: "UTC")!
//        calendar.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
    }
    
    
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
        guard end > start else {
            return 0
        }
        
//        var start = start.toGlobalTime()
//        let end = end.toGlobalTime()
        var start = start
        //let end = end.toGlobalTime()
        
        var intervalsToCalc = [(weekday: Int, start: Date, end: Date)]()
        
        for _ in 1...100 {
            let endCurrentDay = startDayDate(start, 1)
            if endCurrentDay < end {
                intervalsToCalc.append((calendar.component(.weekday, from: start), start, endCurrentDay))
                start = endCurrentDay
            }else{
                if start < end {
                    intervalsToCalc.append((calendar.component(.weekday, from: start), start, end))
                }
                break
            }
        }
        
        guard let setPrices = DataBase.shared.getSetPricesLast() else {return 0}
        
        var intervalsToCalcWithPrices = [(weekday: Int, start: Date, end: Date, price: Double)]()
        
        for intervalsToCalcItem in intervalsToCalc {
            for pricesItem in setPrices.vtPrices {
                
                if intervalsToCalcItem.weekday == pricesItem.weekday {
                    
                    guard let startOfDay = calendar.dateInterval(of: .day, for: intervalsToCalcItem.start)?.start else { continue }
                    let componentStart2 = calendar.dateComponents([.hour, .minute], from: pricesItem.startTime)
                    guard let startPrice = calendar.date(byAdding: componentStart2, to: startOfDay) else { continue }
                    
                    let componentEnd2 = calendar.dateComponents([.hour, .minute], from: pricesItem.endTime)
                    guard let endPrice = calendar.date(byAdding: componentEnd2, to: startOfDay) else { continue }
                    
                    if let intersection = intersectionOfPeriods(intervalsToCalcItem.start.toLocalTime(), intervalsToCalcItem.end.toLocalTime(), startPrice, endPrice) {
                        intervalsToCalcWithPrices.append((weekday: intervalsToCalcItem.weekday,
                                                          start: intersection.start,
                                                          end: intersection.end,
                                                          price: pricesItem.price))
                    }
                }
            }
        }
        
        var amount: Double = 0
        
        for intervalsToCalcWithPricesItem in intervalsToCalcWithPrices {
            amount += intervalsToCalcWithPricesItem.price * Double(calendar.dateComponents([.minute],
                                                                                    from: intervalsToCalcWithPricesItem.start,
                                                                                    to: intervalsToCalcWithPricesItem.end).minute ?? 0)/60
        }
        
        return round(amount*100)/100
    }
    
    func startDayDate(_ date: Date, _ addDays: Int = 0) -> (Date) {
      
        guard let startOfDay = calendar.dateInterval(of: .day, for: date)?.start else {
           return Date(timeIntervalSince1970: 0)
        }
        
        return calendar.date(byAdding: .day, value: addDays, to: startOfDay) ?? Date(timeIntervalSince1970: 0)
    }
    
    func intersectionOfPeriods(_ start1: Date, _ end1: Date, _ start2: Date, _ end2: Date) -> ((start: Date, end: Date)?) {
        if end1 <= start2 || end2 <= start1 || end1 <= start1 || end2 <= start2 {
            return nil
        }
        
        var start = start1
        if start1 > start2 {
            start = start1
        }else{
            start = start2
        }
        
        var end = end1
        if end1 < end2 {
            end = end1
        }else{
            end = end2
        }
        
       return (start: start, end: end)
    }
    
    
}


extension Date {

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
