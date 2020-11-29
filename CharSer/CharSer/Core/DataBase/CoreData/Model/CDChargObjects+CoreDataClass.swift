//
//  CDChargObjects+CoreDataClass.swift
//  CharSer
//
//  Created by Андрей Закусов on 02.11.2020.
//
//

import Foundation
import CoreData

@objc(CDChargObjects)
public class CDChargObjects: NSManagedObject {
    
    

}

extension CDChargObjects:  ReferenceObjectDB{
    
    func getModelByObjectDB() -> (ReferenceModel) {
        let modelObject = СhargObject()
        modelObject.id = Int(self.id)
        modelObject.name = self.name ?? ""
        modelObject.startTime = self.startTime ?? Date()
        modelObject.shutdownTime = self.shutdownTime ?? Date()
        
        return modelObject
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        if let modelObject = modelObject as? СhargObject {
            self.id = Int32(modelObject.id)
            self.name = modelObject.name
            self.startTime = modelObject.startTime
            self.shutdownTime = modelObject.shutdownTime
        }
    }
    
}
