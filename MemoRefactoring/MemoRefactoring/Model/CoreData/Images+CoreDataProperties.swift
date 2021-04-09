//
//  Images+CoreDataProperties.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/06.
//
//

import Foundation
import CoreData


extension Images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest<Images>(entityName: "Images")
    }

    @NSManaged public var date: Date?
    @NSManaged public var identifier: Data?
    @NSManaged public var images: Memo?

}

extension Images : Identifiable {

}
