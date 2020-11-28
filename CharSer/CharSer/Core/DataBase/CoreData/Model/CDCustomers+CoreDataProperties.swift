//
//  CDCustomers+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.11.2020.
//
//

import Foundation
import CoreData


extension CDCustomers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCustomers> {
        return NSFetchRequest<CDCustomers>(entityName: "CDCustomers")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var id: Int32

}

extension CDCustomers : Identifiable {

}
