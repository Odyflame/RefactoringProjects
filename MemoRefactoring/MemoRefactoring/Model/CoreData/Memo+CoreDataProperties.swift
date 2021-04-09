//
//  Memo+CoreDataProperties.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/06.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var date: Date?
    @NSManaged public var identifier: UUID?
    @NSManaged public var memo: String?
    @NSManaged public var modifyDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var images: NSSet?

}

extension Memo : Identifiable {

}
//// MARK: Generated accessors for images
//extension Memo {
//
//    @objc(addImagesObject:)
//    @NSManaged public func addToImages(_ value: Images)
//
//    @objc(removeImagesObject:)
//    @NSManaged public func removeFromImages(_ value: Images)
//
//    @objc(addImages:)
//    @NSManaged public func addToImages(_ values: NSSet)
//
//    @objc(removeImages:)
//    @NSManaged public func removeFromImages(_ values: NSSet)
//
//}
