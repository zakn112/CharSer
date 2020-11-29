//
//  CDCustomerOrders+CoreDataClass.swift
//  CharSer
//
//  Created by Андрей Закусов on 21.11.2020.
//
//

import Foundation
import CoreData

@objc(CDCustomerOrders)
public class CDCustomerOrders: NSManagedObject {

}

extension CDCustomerOrders:  ReferenceObjectDB{
    
    func getModelByObjectDB() -> (ReferenceModel) {
        let modelObject = CustomerOrder()
        modelObject.id = Int(self.id)
        modelObject.date = self.date ?? Date()
        modelObject.startDate = self.startDate ?? Date()
        modelObject.endDate = self.endDate ?? Date()
        modelObject.amount = self.amount
        modelObject.amountPaid = self.amountPaid
        
        if let chargObjectDB = self.chargObject {
            modelObject.chargObject = chargObjectDB.getModelByObjectDB() as? СhargObject
        }
        
        if let customerDB = self.customer {
            modelObject.customer = customerDB.getModelByObjectDB() as? Customer
        }
        
        if let autorDB = self.author {
            modelObject.author = autorDB.getModelByObjectDB() as? User
        }
        
        return modelObject
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        if let modelObject = modelObject as? CustomerOrder {
            
            let db = DBCoreData.shared
            
            self.id = Int32(modelObject.id)
            self.date = modelObject.date
            self.startDate = modelObject.startDate
            self.endDate = modelObject.endDate
            self.amount = modelObject.amount
            self.amountPaid = modelObject.amountPaid
            
            if modelObject.chargObject == nil {
                self.chargObject = nil
            }else{
                self.chargObject = db.getObjectDB(type: CDChargObjects.self, byID: Int16(modelObject.chargObject!.id))
            }
            
            if modelObject.customer == nil {
                self.customer = nil
            }else{
                self.customer = db.getObjectDB(type: CDCustomers.self, byID: Int16(modelObject.customer!.id))
            }
            
            if modelObject.author == nil {
                self.author = nil
            }else{
                self.author = db.getObjectDB(type: CDUsers.self, byID: Int16(modelObject.author!.id))
            }
        }
        
        
    }
    
}
