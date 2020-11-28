//
//  CDChargObjects+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.11.2020.
//
//

import Foundation
import CoreData


extension CDChargObjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChargObjects> {
        return NSFetchRequest<CDChargObjects>(entityName: "CDChargObjects")
    }

    @NSManaged public var name: String?
    @NSManaged public var shutdownTime: Date?
    @NSManaged public var startTime: Date?
    @NSManaged public var id: Int32
    @NSManaged public var setPrises: NSSet?

}

// MARK: Generated accessors for setPrises
extension CDChargObjects {

    @objc(addSetPrisesObject:)
    @NSManaged public func addToSetPrises(_ value: CDSetPrices)

    @objc(removeSetPrisesObject:)
    @NSManaged public func removeFromSetPrises(_ value: CDSetPrices)

    @objc(addSetPrises:)
    @NSManaged public func addToSetPrises(_ values: NSSet)

    @objc(removeSetPrises:)
    @NSManaged public func removeFromSetPrises(_ values: NSSet)

}

extension CDChargObjects : Identifiable {

}
