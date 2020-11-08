//
//  CDSetPrices+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.11.2020.
//
//

import Foundation
import CoreData


extension CDSetPrices {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSetPrices> {
        return NSFetchRequest<CDSetPrices>(entityName: "CDSetPrices")
    }

    @NSManaged public var id: Int32
    @NSManaged public var date: Date?
    @NSManaged public var chargObject: CDChargObjects?
    @NSManaged public var vtPrices: NSSet?

}

// MARK: Generated accessors for vtPrices
extension CDSetPrices {

    @objc(addVtPricesObject:)
    @NSManaged public func addToVtPrices(_ value: CDSetPricesVTPrices)

    @objc(removeVtPricesObject:)
    @NSManaged public func removeFromVtPrices(_ value: CDSetPricesVTPrices)

    @objc(addVtPrices:)
    @NSManaged public func addToVtPrices(_ values: NSSet)

    @objc(removeVtPrices:)
    @NSManaged public func removeFromVtPrices(_ values: NSSet)

}

extension CDSetPrices : Identifiable {

}
