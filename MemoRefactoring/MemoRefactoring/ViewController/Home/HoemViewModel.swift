//
//  HoemViewModel.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/09.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeViewModelInputs {
    func getMemo()
    func deleteMemo(identifier: UUID)
    func flushData()
}

protocol HomeViewModelOutputs {
    var memos: BehaviorRelay<[MemoData]> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs {get }
}

class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    var memos: BehaviorRelay<[MemoData]> = BehaviorRelay(value: [])
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self}
    
    let coreData: CoreDataModelType
    
    private let disposeBag = DisposeBag()
    
    init(coreData: CoreDataModelType) {
        self.coreData = coreData
        coreData.outputs.memos.subscribe(onNext: {(data) in
            self.memos.accept(data)
        }).disposed(by: disposeBag)
    }
    
    func getMemo() {
        self.coreData.inputs.getMemos()
    }
    
    func deleteMemo(identifier: UUID) {
        self.coreData.inputs.delete(identifier: identifier)
    }
    
    func flushData() {
        CoreDataManager.shared.flushData()
        getMemo()
    }
}
