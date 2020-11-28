//
//  CDCustomers+CoreDataClass.swift
//  CharSer
//
//  Created by Андрей Закусов on 02.11.2020.
//
//

import Foundation
import CoreData

@objc(CDCustomers)
public class CDCustomers: NSManagedObject {

}

extension CDCustomers:  ReferenceObjectDB{
    
    typealias modelType = Customer
    
    func getModelByObjectDB() -> (ReferenceModel) {
        let modelObject = Customer()
        modelObject.id = Int(self.id)
        modelObject.name = self.name ?? ""
        modelObject.phone = self.phone ?? ""

        return modelObject
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        if let modelObject = modelObject as? Customer {
            self.id = Int32(modelObject.id)
            self.name = modelObject.name
            self.phone = modelObject.phone
        }
    }
    
}


