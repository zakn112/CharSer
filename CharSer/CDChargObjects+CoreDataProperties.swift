//
//  CDChargObjects+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 02.11.2020.
//
//

import Foundation
import CoreData


extension CDChargObjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChargObjects> {
        return NSFetchRequest<CDChargObjects>(entityName: "CDChargObjects")
    }

    @NSManaged public var id: Int
    @NSManaged public var name: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var shutdownTime: Date?

}

extension CDChargObjects : Identifiable {

}




