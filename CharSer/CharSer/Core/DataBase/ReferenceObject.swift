//
//  ReferenceObject.swift
//  CharSer
//
//  Created by Андрей Закусов on 31.10.2020.
//

import Foundation
import RealmSwift

protocol ReferenceObjectDB {
    var id:Int { get set }
    func getModelByObjectDB() -> (ReferenceModel)
    func getObjetType() -> (Object.Type)
    func fillByModel(modelObject: ReferenceModel) -> (Void)
}
