//
//  CDUsers+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 01.11.2020.
//
//

import Foundation
import CoreData


extension CDUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUsers> {
        return NSFetchRequest<CDUsers>(entityName: "CDUsers")
    }

    @NSManaged public var id: Int
    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var role: String?

}

extension CDUsers : Identifiable {

}
