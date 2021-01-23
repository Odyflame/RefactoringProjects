//
//  VocaCoreDataManager.swift
//  PoingVocaSubsystem
//
//  Created by Hanteo on 2021/01/23.
//

import Foundation
import CoreData

public class VocaCoreDataManager {
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
    
    public override init() {
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextObjectDidchange(_:)),
            name: <#T##NSNotification.Name?#>,
            object: <#T##Any?#>)
    }
    
    var backgroundContext: NSManagedObjectContext {
        persistentContainer.viewContext
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
    
    @objc private func contextObjectDidChange(_ notification: NSNotification) {
        NotificationCenter.default.post(name: .vocaDataChanged, object: self)
    }
    
    @objc func fetchChanges(_ notification: NSNotification) {
        print("###\(#function): fetchChange.")
        
    }
}

extension VocaCoreDataManager {
    
}
