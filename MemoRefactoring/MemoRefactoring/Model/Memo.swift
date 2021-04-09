//
//  Memo.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/06.
//

import UIKit

public struct MemoData {
    
    let title: String?
    let memo: String?
    let date: Date?
    var modifyDate: Date?
    let identifier: UUID?
    var imageArray: [Image]?
}

extension MemoData {
    public init() {
        title = ""
        memo = ""
        date = Date()
        modifyDate = Date()
        identifier = UUID()
        imageArray = []
    }
    
    init(memo: Memo, imageArray: [Image])
    {
        self.title = memo.title
        self.memo = memo.memo
        self.date = memo.date
        self.modifyDate = memo.modifyDate
        self.identifier = memo.identifier
        self.imageArray = imageArray
    }
}
