//
//  CardMatching.swift
//  VocaGame
//
//  Created by Hanteo on 2021/04/02.
//

import UIKit

class CardMatching {
    enum ContentType {
        case image(_ image: UIImage)
        case imageURL(_ imageURL: URL)
        case text(_ text: String)
    }
    
    let color: UIColor
    let contentType: ContentType
    let uuid: UUID
    
    init(contentType: ContentType, uuid: UUID, color: UIColor) {
        self.contentType = contentType
        self.uuid = uuid
        self.color = color
    }
}
