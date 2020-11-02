//
//  ReferenceСhargObject.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.10.2020.
//

import Foundation
import RealmSwift

class ReferenceСhargObject: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var startTime:Date = Date()
    @objc dynamic var shutdownTime:Date = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension ReferenceСhargObject: ReferenceObjectDB {
    func getModelByObjectDB() -> (ReferenceModel) {
 
        let objectModel = СhargObject()
        
        objectModel.name = self.name
        objectModel.startTime = self.startTime
        objectModel.shutdownTime = self.shutdownTime
        objectModel.id = self.id
        
        return objectModel
    }
    
    func getObjetType() -> (Object.Type){
        return ReferenceСhargObject.self
    }
    
    func fillByModel(modelObject: ReferenceModel) {
        
        guard let modelObject = modelObject as? СhargObject else {
            return
        }
        self.id = modelObject.id
        self.name = modelObject.name
        
    }
}
