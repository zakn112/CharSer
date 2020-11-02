//
//  DocumentSettingTariffs.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.10.2020.
//

import Foundation
import RealmSwift

class DocumentSettingTariffs: Object {
    @objc dynamic var settingTariffsID:Int = 0
    @objc dynamic var date:Date = Date()
    @objc dynamic var number:String = ""
    @objc dynamic var chargObjectID:Int = 0
    
    override class func primaryKey() -> String? {
        return "settingTariffsID"
    }
}
