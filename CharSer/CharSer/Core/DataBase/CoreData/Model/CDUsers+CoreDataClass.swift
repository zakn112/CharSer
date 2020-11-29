//
//  CDUsers+CoreDataClass.swift
//  CharSer
//
//  Created by Андрей Закусов on 01.11.2020.
//
//

import Foundation
import CoreData

@objc(CDUsers)
public class CDUsers: NSManagedObject {

}

extension CDUsers:  ReferenceObjectDB{
    
    func getModelByObjectDB() -> (ReferenceModel) {
        let objectModel = User()
        
        objectModel.id = Int(self.id)
        objectModel.firstName = self.firstName ?? ""
        objectModel.lastName = self.lastName ?? ""
        objectModel.login = self.login ?? ""
        if  self.role == "admin" {
            objectModel.role = .admin
        }else if self.role == "user" {
            objectModel.role = .user
        }
        
        return objectModel
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        if let modelObject = modelObject as? User {
            
            self.id = Int32(modelObject.id)
            self.firstName = modelObject.firstName
            self.lastName = modelObject.lastName
            self.login = modelObject.login
            if modelObject.role == .admin {
                self.role = "admin"
            }else if modelObject.role == .user {
                self.role = "user"
            }
        }
    }
    
}
