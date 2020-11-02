//
//  ReferenceСustomer.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.10.2020.
//

import Foundation
import RealmSwift

class ReferenceСustomer: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var phone:String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension ReferenceСustomer: ReferenceObjectDB {
    func getModelByObjectDB() -> (ReferenceModel) {
      
        let objectModel = Customer()
        
        objectModel.name = self.name
        objectModel.phone = self.phone
        objectModel.id = self.id
        
        return objectModel
    }
    
    func getObjetType() -> (Object.Type){
        return ReferenceСustomer.self
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        
    }
}
