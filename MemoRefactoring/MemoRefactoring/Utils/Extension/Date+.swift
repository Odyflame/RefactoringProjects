//
//  Date+.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/08.
//

import Foundation

extension Date {
    static var dateFormatterkor: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy년 M월 d일 hh:mm:ss"
        return dateFormat
    }()
    
    static var dateFormatter20xxMMdd: DateFormatter = {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyyMMdd"
        return dateStringFormatter
    }()
    
    static var dateFormatterHour: DateFormatter = {
       let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "HH"
        return dateStringFormatter
    }()
    
    func korDateString() -> String {
        return Date.dateFormatterkor.string(from: self)
    }
    
}
