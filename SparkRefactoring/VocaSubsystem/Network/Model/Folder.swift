//
//  Folder.swift
//  VocaSubsystem
//
//  Created by Hanteo on 2021/03/18.
//

import Foundation

public class Folder: Codable {
    internal init(default: Bool, id: Int, name: String, shareable: Bool, photoUrl: String) {
        self.default = `default`
        self.id = id
        self.name = name
        self.shareable = shareable
        self.photoUrl = photoUrl
    }

    public var `default`: Bool
    public var id: Int
    public var name: String
    public var shareable: Bool
    public var photoUrl: String
}
