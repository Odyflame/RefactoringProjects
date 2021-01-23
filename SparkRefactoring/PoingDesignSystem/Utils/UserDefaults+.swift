//
//  UserDefaults+.swift
//  PoingDesignSystem
//
//  Created by Hanteo on 2021/01/23.
//

import Foundation

extension UserDefaults {
    static func flushUserInformation() {
//        Token.shared.token = nil
//        User.shared.userInfo = nil
//        UserDefaults.standard.setValue(nil, forKey: "LoginIdentifier")
//        GameGuideUtill.reset()
    }
    
    func setUserLoginIdentifier(identifier: String) {
        UserDefaults.standard.setValue(identifier, forKey: "LoginIdentifier")
    }
    
    func getUserLoginIdentifier() -> String? {
        UserDefaults.standard.string(forKey: "LoginIdentifier")
    }
}
