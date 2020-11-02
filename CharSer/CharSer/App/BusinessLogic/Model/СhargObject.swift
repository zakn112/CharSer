//
//  СhargObject.swift
//  CharSer
//
//  Created by Андрей Закусов on 31.10.2020.
//

import Foundation

class СhargObject: ReferenceModel {
    var id:Int = 0
    var name:String = ""
    var startTime:Date = Date()
    var shutdownTime:Date = Date()
}
