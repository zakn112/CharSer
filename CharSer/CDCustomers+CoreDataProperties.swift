//
//  CDCustomers+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 02.11.2020.
//
//

import Foundation
import CoreData


extension CDCustomers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCustomers> {
        return NSFetchRequest<CDCustomers>(entityName: "CDCustomers")
    }

    @NSManaged public var id: Int
    @NSManaged public var name: String?
    @NSManaged public var phone: String?

}

extension CDCustomers : Identifiable {

}
