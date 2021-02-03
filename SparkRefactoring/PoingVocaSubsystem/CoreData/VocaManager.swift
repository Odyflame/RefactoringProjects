//
//  VocaManager.swift
//  PoingVocaSubsystem
//
//  Created by Hanteo on 2021/01/28.
//

import Foundation

public class VocaManager {
    public static let shared = VocaManager()
    public var groups: [FolderCoreData]?
    
    public func insertDefaultGroup(completion: @escaping (() -> Void)) {
        let defaultGroup = FolderCoreData(
            name: "기본 폴더",
            visibilityType: .default,
            identifier: UUID(),
            words: [],
            order: -1)
        
        VocaCoreDataManager.shared.performBackgorundTask { (context) in
            let groups = VocaCoreDataManager.shared.fetch(predicate: .default, context: context)
            if groups?.isEmpty ?? true {
                VocaCoreDataManager.shared.insert(group: defaultGroup, context: context)
            }
            completion()
        }
    }
    
    public func deleteAllGroup() {
        
    }
    
    public func fetch(
        identifier: UUID?,
        completion: @escaping (([FolderCoreData]?) -> Void)
    ) {
        VocaCoreDataManager.shared.performBackgorundTask { (context) in
            guard let managedGroups = VocaCoreDataManager.shared.fetch(predicate: identifier, context: context) else {
                completion(nil)
                return
            }
            
            var groups = [FolderCoreData]()
            for managedGroup in managedGroups {
                groups.append(managedGroup.toGroup())
            }
            
            self.groups = groups
            completion(groups)
        }
    }
    
    public func fetch(
        visibilityType: VisibilityType,
        completion: @escaping (([FolderCoreData]?) -> Void)) {
        VocaCoreDataManager.shared.performBackgorundTask { (context) in
            guard let managedGroups = VocaCoreDataManager.shared.fetch(predicate: visibilityType, context: context) else {
                completion(nil)
                return
            }
            
            var groups = [FolderCoreData]()
            for managedGroup in managedGroups {
                groups.append(managedGroup.toGroup())
            }
            
            completion(groups)
        }
    }
    
    public func insert(group: FolderCoreData, completion: (() -> Void)? = nil) {
        VocaCoreDataManager.shared.performBackgorundTask { (context) in
            VocaCoreDataManager.shared.insert(group: group, context: context)
            guard let completion = completion else {
                return
            }
            completion()
        }
    }
    
    public func delete(group: FolderCoreData, completion: (() -> Void)? = nil) {
        VocaCoreDataManager.shared.performBackgorundTask { (context) in
            VocaCoreDataManager.shared.delete(identifier: group.identifier, context: context)
            guard let completion = completion else {
                return
            }
            completion()
        }
    }
    
    public func update(group: FolderCoreData, deleteWords: [WordCoreData], completion: (() -> Void)? = nil) {
        let currentWords = group.words.filter { (groupWord) -> Bool in
            deleteWords.contains { (word) -> Bool in
                word.identifier != groupWord.identifier
            }
        }
        
        var currentGroup = group
        currentGroup.words = currentWords
        
        //update
    }
    
    public func update(group: FolderCoreData, completion: (() -> Void)? = nil) {
        
    }
}
