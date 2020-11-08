//
//  CDSetPricesVTPrices+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.11.2020.
//
//

import Foundation
import CoreData


extension CDSetPricesVTPrices {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSetPricesVTPrices> {
        return NSFetchRequest<CDSetPricesVTPrices>(entityName: "CDSetPricesVTPrices")
    }

    @NSManaged public var setPricesId: Int32
    @NSManaged public var weekday: Int16
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var price: Float
    @NSManaged public var setPrises: NSSet?

}

// MARK: Generated accessors for setPrises
extension CDSetPricesVTPrices {

    @objc(addSetPrisesObject:)
    @NSManaged public func addToSetPrises(_ value: CDSetPrices)

    @objc(removeSetPrisesObject:)
    @NSManaged public func removeFromSetPrises(_ value: CDSetPrices)

    @objc(addSetPrises:)
    @NSManaged public func addToSetPrises(_ values: NSSet)

    @objc(removeSetPrises:)
    @NSManaged public func removeFromSetPrises(_ values: NSSet)

}

extension CDSetPricesVTPrices : Identifiable {

}
