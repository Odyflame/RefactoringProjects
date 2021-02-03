//
//  VocaCoreDataManager.swift
//  PoingVocaSubsystem
//
//  Created by Hanteo on 2021/01/23.
//

import Foundation
import CoreData

public class VocaCoreDataManager: NSObject {
    static let shared = VocaCoreDataManager()
    let modelName = "Voca"
    
    private lazy var historyQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { (NSPersistentStoreDescription, Error) in
            guard Error == nil else {
                fatalError("Could not load persistent stores. \(Error!)")
            }
        }
        
        return container
    }()
    
    var backgroundContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    public override init() {
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextObjectDidChange(_:)),
            name: .NSManagedObjectContextObjectsDidChange,
            object: persistentContainer.viewContext)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchChanges(_:)),
            name: .NSPersistentStoreRemoteChange,
            object: persistentContainer.persistentStoreCoordinator)
    }
    
    
    func performBackgorundTask(_ completion: @escaping (NSManagedObjectContext) -> Void ) {
        let context = backgroundContext
        context.perform { () -> Void in
            completion(context)
        }
    }
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // groupList를 받아오는것
    func fetch(predicate identifier: UUID?, context: NSManagedObjectContext) -> [ManagedGroup]? {
        let fetchRequest = NSFetchRequest<ManagedGroup>(entityName: "Group") // Group의 entity를 받아오는것
        
        if let identifier = identifier {
            fetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier as CVarArg)
            fetchRequest.fetchLimit = 1
        }
        
        guard let groupList = try? context.fetch(fetchRequest),
              groupList.isEmpty == false
              else {
            return nil
        }
        return groupList
    }
    
    func fetch(predicate visibilityType: VisibilityType,
               context: NSManagedObjectContext) -> [ManagedGroup]? {
        let fetchRequest = NSFetchRequest<ManagedGroup>(entityName: "Group")
        
        fetchRequest.predicate = NSPredicate(format: "visibilityType == %@", visibilityType.rawValue)
        
        guard let groupList = try? context.fetch(fetchRequest) else {
            return nil
        }
        return groupList
    }
    
    func insert(group: FolderCoreData, context: NSManagedObjectContext) {
        group.toManaged(context: context)
        saveContext(context: context)
    }
    
    func delete(identifier: UUID, context: NSManagedObjectContext) {
        guard let deleteGroup = fetch(predicate: identifier, context: context) else {
            return
        }
        
        for deleteGroup in deleteGroup {
            context.delete(deleteGroup)
        }
        saveContext(context: context)
    }
    
    func update(group: FolderCoreData, context: NSManagedObjectContext, completion: @escaping (() -> Void)) {
        //fetch해서 받아온 ManagedGroup 배열
        guard let updateGroups = fetch(predicate: group.identifier, context: context) else {
            completion()
            return
        }
        
        for updateGroup in updateGroups {
            updateGroup.title = group.name
            updateGroup.visibilityType = group.visibilityType.rawValue
            var newWordArr = [ManagedWord]()
            for word in group.words {
                newWordArr.append(word.toManaged(context: context))
            }
            updateGroup.words = NSSet(array: newWordArr)
        }
        saveContext(context: context)
        completion()
        
    }
    
    public func reset() {
        let container = persistentContainer
        let coordinator = container.persistentStoreCoordinator
        if let store = coordinator.destroyPersisentStore(type: NSSQLiteStoreType) {
            do {
                try coordinator.addPersistentStore(
                    ofType: NSSQLiteStoreType,
                    configurationName: nil,
                    at: store.url,
                    options: nil)
            } catch {
                print(error)
            }
        }
    }
    
    @objc private func contextObjectDidChange(_ notification: NSNotification) {
        NotificationCenter.default.post(name: .vocaDataChanged, object: self)
    }
    
    @objc func fetchChanges(_ notification: NSNotification) {
        print("###\(#function): fetchChange.")
        
    }
}

extension VocaCoreDataManager {
    /**
     Handle remote store change notifications (.NSPersistentStoreRemoteChange).
     merge 공부중임
     */
    @objc
    func storeRemoteChange(_ notification: Notification) {
        print("###\(#function): Merging changes from the other persistent store coordinator.")

        //print(fetch(predicate: .default, context: backgroundContext))
        // Process persistent history to merge changes from other coordinators.
        historyQueue.addOperation {
//            self.processPersistentHistory()
        }
    }
}

extension NSPersistentStoreCoordinator {
    func destroyPersisentStore(type: String) -> NSPersistentStore? {
        guard let store = persistentStores.first(where: { $0.type == type }),
              let storeURL = store.url else {
            return nil
        }
        try? destroyPersistentStore(at: storeURL, ofType: store.type, options: nil)
        return store
    }
}
