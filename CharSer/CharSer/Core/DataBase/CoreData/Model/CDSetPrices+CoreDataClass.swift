//
//  CDSetPrices+CoreDataClass.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.11.2020.
//
//

import Foundation
import CoreData

@objc(CDSetPrices)
public class CDSetPrices: NSManagedObject {

}

extension CDSetPrices:  ReferenceObjectDB{
    
    func getModelByObjectDB() -> (ReferenceModel) {
        let modelObject = SetPrices()
        modelObject.id = Int(self.id)
        modelObject.date = self.date ?? Date()
        
        if let chargObjectDB = self.chargObject {
            modelObject.chargObject = chargObjectDB.getModelByObjectDB() as? СhargObject
        }
        
        if let vtPrices = self.vtPrices {
           
            modelObject.vtPrices = vtPrices.compactMap{ vtPricesItemDB in
                
                if let vtPricesItemDB = vtPricesItemDB as? CDSetPricesVTPrices {
                    return vtPricesItemDB.getModelByObjectDB() as? VTPricesItem
                }
                
                return nil
                
            }.sorted(by: { $0.strNumber < $1.strNumber })
        }
        
        return modelObject
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        if let modelObject = modelObject as? SetPrices {
            self.id = Int32(modelObject.id)
            self.date = modelObject.date
        }
    }
    
}


