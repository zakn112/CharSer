//
//  CDUsers+CoreDataProperties.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.11.2020.
//
//

import Foundation
import CoreData


extension CDUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUsers> {
        return NSFetchRequest<CDUsers>(entityName: "CDUsers")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var role: String?
    @NSManaged public var id: Int32

}

extension CDUsers : Identifiable {

}
