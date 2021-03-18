//
//  ManagedGroup+CoreDataProperties.swift
//  VocaSubsystem
//
//  Created by Hanteo on 2021/03/18.
//
//

import Foundation
import CoreData

public enum VisibilityType: String {
    case `public`
    case `private`
    case group
    case `default`
}

public class FolderCoreData: Folder {
    public init(
        name: String,
        visibilityType: VisibilityType,
        identifier: UUID,
        words: [WordCoreData],
        order: Int16
    ) {
        self.identifier = identifier
        self.words = words
        self.order = order
        self.visibilityType = visibilityType

        super.init(
            default: (visibilityType == .default),
            id: -1,
            name: name,
            shareable: (visibilityType == .public),
            photoUrl: ""
        )
    }
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }

    public var identifier: UUID
    public var words: [WordCoreData]
    public var order: Int16
    public var visibilityType: VisibilityType
}

extension ManagedGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedGroup> {
        return NSFetchRequest<ManagedGroup>(entityName: "Group")
    }

    @NSManaged public var identifier: UUID?
    @NSManaged public var order: Int16
    @NSManaged public var title: String?
    @NSManaged public var visibilityType: String?
    @NSManaged public var words: ManagedWord?

}

// MARK: Generated accessors for words
extension ManagedGroup {

    @objc(addWordsObject:)
    @NSManaged public func addToWords(_ value: ManagedWord)

    @objc(removeWordsObject:)
    @NSManaged public func removeFromWords(_ value: ManagedWord)

    @objc(addWords:)
    @NSManaged public func addToWords(_ values: NSSet)

    @objc(removeWords:)
    @NSManaged public func removeFromWords(_ values: NSSet)

}

extension ManagedGroup {
    func toGroup() -> FolderCoreData {

        var processedWords = [WordCoreData]()
        if let managedWords = words as? Set<ManagedWord> {
            for managedWord in managedWords {
                processedWords.append(managedWord.toWord())
            }

            processedWords = processedWords.sorted {
                $0.order < $1.order
            }
        }

        let isVailableVisibilityType = VisibilityType(rawValue: visibilityType ?? "") ?? .private

        let group = FolderCoreData(
            name: title ?? "",
            visibilityType: isVailableVisibilityType,
            identifier: identifier ?? UUID(),
            words: processedWords,
            order: order
        )
        return group
    }
}
