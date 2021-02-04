//
//  GameGuideUtill.swift
//  VocaGame
//
//  Created by Hanteo on 2021/02/04.
//

import UIKit

public enum GameGuideUtill {
    static var isNeedGuide: Bool {
        return UserDefaults.standard.bool(forKey: "VocaGame.Guide.Flip")
    }
    static func didShowGuide() {
         UserDefaults.standard.set(true, forKey: "VocaGame.Guide.Flip")
    }
    public static func reset() {
        UserDefaults.standard.set(false, forKey: "VocaGame.Guide.Flip")
    }
}
