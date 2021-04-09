//
//  CoreDataModel.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/09.
//

import UIKit
import RxSwift
import CoreData

protocol CoreDataModelInputs {
    func getMemos()
    func add(newMemo: MemoData) -> (Bool, Error?)
    func delete(identifier: UUID) -> (Bool, Error?)
    func update(updateMemo: MemoData) -> (Bool, Error?)
}

protocol CoreDataModelOutputs {
    var memos: PublishSubject<[MemoData]> { get }
}

protocol CoreDataModelType {
    var inputs: CoreDataModelType { get }
    var outputs: CoreDataModelOutputs { get }
}

class CoreDataModel: CoreDataModelInputs, CoreDataModelOutputs, CoreDataModelType {
    
    var memos: PublishSubject<[MemoData]>
    
    var inputs: CoreDataModelType { return self }
    
    var outputs: CoreDataModelOutputs { return self }
    
    init() {
        self.memos = PublishSubject() // relay와 subject의 차이점
        
        /**
         subject는 실시간으로 obsevable에 값을 추가하고 ,suscriber를 할 수 있는 것이 필요하다
         이때 Observable이자 Observer를 Subject라고 한다
         Relay란 rxCocoa에서 구현된 것이다.
         subject는 .complete, .error이벤트가 발생하면 subscribe가 종료되지만
         relay는 .complete, .error를 발생하지 않고 dispose되기까지 계속 작동하여 UIEvent에서 사용하기 적절함
         */
        
    }
    
    func getMemos() {
        var fetchMomoDataArray: [MemoData] = []
        
        if let result = CoreDataManager.shared.fetchAllMemos() {
            for data in result {
                let ImagesInCoreData = getImages(memo: data)
                
                let tempData: MemoData = MemoData(memo: data, imageArray: ImagesInCoreData)
                fetchMomoDataArray.append(tempData)
            }
        }
        
        memos.onNext(fetchMomoDataArray)
    }
    
    private func getImages(memo: Memo) -> [Image] {
        var UIImageArr: [Image] = []
        if let iamgeData = memo.images as? Set<Images> { //NSSet은 Set<Image>로 바꿀수도있나봄
            
            let sortedImageByDate = iamgeData.sorted {
                return $0.date! < $1.date!
            }
            
            for image in sortedImageByDate {
                var structImage = getImage(image: image)
                UIImageArr.append(structImage)
            }
            
        }
        return UIImageArr
    }
    
    private func getImage(image: Images) -> Image {
        var structImage = Image()
        structImage.date = image.date ?? Date()
        if let imageIdentifier = image.identifier {
            structImage.image = UIImage.init(data: imageIdentifier) ?? UIImage()
        }
        return structImage
    }
    
    func add(newMemo: MemoData) -> (Bool, Error?) {
        return CoreDataManager.shared.add(newMemo: newMemo)
    }
    
    func delete(identifier: UUID) -> (Bool, Error?) {
        return CoreDataManager.shared.delete(identifier: identifier)
    }
    
    func update(updateMemo: MemoData) -> (Bool, Error?) {
        return CoreDataManager.shared.update(updateMemo: updateMemo)
    }
    
}

