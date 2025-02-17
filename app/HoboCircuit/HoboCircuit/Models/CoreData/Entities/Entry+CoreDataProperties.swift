//
//  Entry+CoreDataProperties.swift
//  HoboCircuit
//
//  Created by Matti Stenvall on 17.2.2025.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var title: String?
    @NSManaged public var routine: String?
    @NSManaged public var usernote: String?

}

extension Entry : Identifiable {

}
