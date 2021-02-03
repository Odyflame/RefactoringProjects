//
//  UserInfo.swift
//  PoingVocaSubsystem
//
//  Created by Hanteo on 2021/01/29.
//

import Foundation

public struct UserInfo: Codable {
    public let id: Int
    public let name: String
    public let photoURL: String
}

public class User {
    public static let shared = User()
    public var userInfo: UserInfo?
}

public class Token {
    public static let shared = Token()
    public var token: String?
}

public struct LoginResponse: Codable {
    public let token: String
    public let userResponse: UserInfo
}
