//
//  CDCustomerOrders+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 21.11.2020.
//
//

import Foundation
import CoreData


extension CDCustomerOrders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCustomerOrders> {
        return NSFetchRequest<CDCustomerOrders>(entityName: "CDCustomerOrders")
    }

    @NSManaged public var id: Int32
    @NSManaged public var date: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var amount: Double
    @NSManaged public var amountPaid: Double
    @NSManaged public var chargObject: CDChargObjects?
    @NSManaged public var customer: CDCustomers?
    @NSManaged public var author: CDUsers?

}

extension CDCustomerOrders : Identifiable {

}
