//
//  GameCell.swift
//  Vocabulary
//
//  Created by user on 2020/08/01.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import UIKit
import SnapKit
import PoingDesignSystem
import VocaGame

class GameCell: UICollectionViewCell {
    enum Constant {
        enum Thum {
            static let height: CGFloat = 32
        }
        enum Title {
            static let font = UIFont.systemFont(ofSize: 20, weight: .bold)
            static let color = UIColor.midnight
        }
    }
    
    static let reuseIdentifier = String(describing: GameCell.self)
    
    lazy var containerVioew: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
    }()
}
