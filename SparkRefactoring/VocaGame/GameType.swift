//
//  GameType.swift
//  VocaGame
//
//  Created by Hanteo on 2021/03/18.
//
import UIKit

public enum GameType: String {
    case flip = "뒤집기"
    case matching = "매칭 게임"
}

public struct GameStyle {
    public init(type: GameType, image: UIImage?) {
        self.type = type
        self.image = image
    }

    public let type: GameType
    public let image: UIImage?
}
