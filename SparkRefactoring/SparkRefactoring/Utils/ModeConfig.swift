//
//  ModeConfig.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/02/04.
//

import Foundation

public enum ModeType {
    case offline
    case online
}

public class ModeConfig {
    public static let shared = ModeConfig()
    
    public var currentMode: ModeType = .online {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.modeConfig, object: nil)
        }
    }
}
