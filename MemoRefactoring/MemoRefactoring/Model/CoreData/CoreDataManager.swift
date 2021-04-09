//
//  CoreDataManager.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/06.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    
    override init() {
        super.init()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (_, error) in
            
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func add(newMemo: MemoData) -> (Bool, Error?) {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        var coreDataTypeArr: [Images] = []
        for image in newMemo.imageArray ?? [] {
            if let imageData = (NSEntityDescription.insertNewObject(forEntityName: "Images",
                                                                    into: managedContext) as? Images) {
                imageData.identifier = image.image.jpegData(compressionQuality: 0.8)!
                imageData.date = image.date
                coreDataTypeArr.append(imageData)
            }
        }
        
        let memo = Memo(context: managedContext)
        memo.title = newMemo.title
        memo.memo = newMemo.memo
        memo.date = newMemo.date
        memo.identifier = newMemo.identifier
        memo.images = NSSet(array: coreDataTypeArr)
        
        do {
            try managedContext.save()
            return (true, nil)
        } catch let error as NSError {
            print("could not save. \(error), \(error.localizedDescription)")
            return (false, error)
        }
    }
    
    func delete(identifier: UUID) -> (Bool, Error?) {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        fetchRequest.returnsObjectsAsFaults = false
        // 성능 강화를 위해
        // https://www.notion.so/odyflame/var-returnsObjectsAsFaults-Bool-da4064526cff4b6eb8387d95496ed859 참조
        let predicate = NSPredicate(format: "identifier == %@", identifier as CVarArg)
        // CvarArg = 인스턴스를 인코딩하고 적절하게 전달할 수 있는 형식입니다(Cva_list의 요소입니다.
        fetchRequest.predicate = predicate
        
        do {
            let fetchResults: Array = try managedContext.fetch(fetchRequest)
            
            for fetchResult in fetchResults {
                if let managedObject = fetchResult as? NSManagedObject {
                    
                    managedContext.delete(managedObject)
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return (false, error)
        }
        
        do {
            try managedContext.save()
            return (true, nil)
        } catch let error as NSError {
            return (false, error)
        }
    }
    
    func update(updateMemo: MemoData) -> (Bool, Error?) {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        fetchRequest.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "identifier == %@", updateMemo.identifier! as CVarArg)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        var coreDataTypeArr: [Images] = []
        
        for image in updateMemo.imageArray ?? [] {
            if let imageData = (NSEntityDescription.insertNewObject(forEntityName: "Images",
                                                                    into: managedContext) as? Images) {
                imageData.identifier = image.image.jpegData(compressionQuality: 0.8)!
                imageData.date = image.date
                coreDataTypeArr.append(imageData)
            }
        }
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest).first
            if let managedObject = fetchResult as? NSManagedObject {
                managedObject.setValue(updateMemo.title, forKey: "title")
                managedObject.setValue(updateMemo.memo, forKey: "memo")
                managedObject.setValue(updateMemo.date, forKey: "date")
                managedObject.setValue(updateMemo.modifyDate, forKey: "modifyDate")
                managedObject.setValue(NSSet(array: coreDataTypeArr), forKey: "images")
            }
            
            do {
                try managedContext.save()
                return (true, nil)
            } catch let error as NSError {
                return (false, error)
            }
        } catch let error as NSError {
            return (false, error)
        }
    }
    
    // fetch all memo
    func fetchAllMemos() -> [Memo]? {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<Memo>(entityName: "Memo")
        
        if NSClassFromString("XCTest") != nil {
            fetchRequest2.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        } else {
            let orderType = userPreferences.getOrderType()
            switch orderType {
            case .title:
                fetchRequest2.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
            case .createDate:
                fetchRequest2.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            case .modifyDate:
                fetchRequest2.sortDescriptors = [NSSortDescriptor(key: "modifyDate", ascending: false)]
            }
        }
        
        do {
          let memos = try managedContext.fetch(fetchRequest2)
          return memos
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
          return nil
        }
    }
    
    // flush -> 모든 데이터를 없애는 것
    // 루트는 컨테이너 -> fetch request -> viewContext를 fetch받은 녀석을 하나하나 삭제하고 저장
    func flushData() {
        let container = NSPersistentContainer(name: "MemoApp")
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        if let objs = try? CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest) {
            for case let obj as NSManagedObject in objs {
              CoreDataManager.shared.persistentContainer.viewContext.delete(obj)
            }
            try? CoreDataManager.shared.persistentContainer.viewContext.save()
        }
    }
    
    func reset() {
        let container = persistentContainer
        let coordinator = container.persistentStoreCoordinator
        
        if let store = coordinator.destroyPersistentStore(type: NSSQLiteStoreType) {
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
      NotificationCenter.default.post(name: .memoDataChanged, object: self)
    }
}

extension NSPersistentStoreCoordinator {
    func destroyPersistentStore(type: String) -> NSPersistentStore? {
        guard
            let store = persistentStores.first( where: { $0.type == type}),
            let storeURL = store.url
        else {
            return nil
        }
        
        try? destroyPersistentStore(at: storeURL, ofType: type, options: nil)
        
        return store
    }
}
