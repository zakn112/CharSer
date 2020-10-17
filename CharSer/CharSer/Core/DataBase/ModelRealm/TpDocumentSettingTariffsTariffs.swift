//
//  TpDocumentSettingTariffsTariffs.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.10.2020.
//

import Foundation
import RealmSwift

class TpDocumentSettingTariffsTariffs: Object {
    @objc dynamic var settingTariffs_ID:Int = 0
    @objc dynamic var Weekday:Int8 = 0
    @objc dynamic var startTime:Date = Date()
    @objc dynamic var endTime:Date = Date()
    @objc dynamic var cost:Double = 0
    
}
