//
//  ReferenceUser.swift
//  CharSer
//
//  Created by Андрей Закусов on 11.10.2020.
//

import Foundation
import RealmSwift

class ReferenceUser: Object {
    @objc dynamic var login:String = ""
    @objc dynamic var password:String = ""
    
    @objc dynamic var firstName:String = ""
    @objc dynamic var lastName:String = ""
    
    @objc dynamic var role:String = ""
    
    var id: Int = 0
    
    
    override class func primaryKey() -> String? {
        return "login"
    }
}

extension ReferenceUser: ReferenceObjectDB {
   
    
    
    func getModelByObjectDB() -> (ReferenceModel) {
        
        let objectModel = User()
        
        objectModel.firstName = self.firstName
        objectModel.lastName = self.lastName
        objectModel.login = self.login
        if  self.role == "admin" {
            objectModel.role = .admin
        }else if self.role == "user" {
            objectModel.role = .user
        }
        
        return objectModel
    }
    
    func getObjetType() -> (Object.Type){
        return ReferenceUser.self
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        
    }
}
