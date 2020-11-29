//
//  ReferenceObject.swift
//  CharSer
//
//  Created by Андрей Закусов on 31.10.2020.
//

import Foundation

protocol ReferenceObjectDB {
    var id:Int32 { get set }
    func getModelByObjectDB() -> (ReferenceModel)
    func fillByModel(modelObject: ReferenceModel) -> (Void)
}
