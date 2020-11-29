//
//  CDSetPricesVTPrices+CoreDataClass.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.11.2020.
//
//

import Foundation
import CoreData

@objc(CDSetPricesVTPrices)
public class CDSetPricesVTPrices: NSManagedObject {

}

extension CDSetPricesVTPrices:  ReferenceObjectDB{
    
    func getModelByObjectDB() -> (ReferenceModel) {
        let modelObject = VTPricesItem()
        modelObject.strNumber = self.strNumber
        modelObject.weekday = self.weekday
        modelObject.startTime = self.startTime ?? Date()
        modelObject.endTime = self.endTime ?? Date()
        modelObject.price = self.price
        
        return modelObject
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        if let modelObject = modelObject as? VTPricesItem {
            self.strNumber = modelObject.strNumber
            self.weekday = modelObject.weekday
            self.startTime = modelObject.startTime
            self.endTime = modelObject.endTime
            self.price = modelObject.price
        }
    }
    
}
