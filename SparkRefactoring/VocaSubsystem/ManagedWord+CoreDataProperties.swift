//
//  ManagedWord+CoreDataProperties.swift
//  VocaSubsystem
//
//  Created by Hanteo on 2021/03/18.
//
//

import Foundation
import CoreData

public class WordCoreData: Word {
    public init(
        korean: String? = nil,
        english: String? = nil,
        imageData: Data? = nil,
        identifier: UUID? = nil,
        order: Int16
    ) {
        self.image = imageData
        self.order = order
        self.identifier = identifier

        super.init(
            id: -0,
            korean: korean ?? "",
            english: english ?? "",
            photoUrl: nil
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    public var image: Data?
    public var identifier: UUID?
    public var order: Int16
    
    func toManaged(context: NSManagedObjectContext) -> ManagedWord {
        let managed = ManagedWord(context: context)
        managed.korean = korean
        managed.image = image
        managed.english = english
        managed.identifier = identifier
        managed.order = order
        return managed
    }
}

extension ManagedWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedWord> {
        return NSFetchRequest<ManagedWord>(entityName: "Word")
    }

    @NSManaged public var english: String?
    @NSManaged public var korean: String?
    @NSManaged public var order: Int16
    @NSManaged public var image: Data?
    @NSManaged public var identifier: UUID?
    @NSManaged public var ofGroup: ManagedGroup?

    func toWord() -> WordCoreData {
        WordCoreData(
            korean: korean ?? "",
            english: english ?? "",
            imageData: image,
            identifier: identifier,
            order: order
        )
    }
}
