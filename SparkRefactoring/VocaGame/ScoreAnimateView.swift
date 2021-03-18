//
//  ScoreAnimateView.swift
//  VocaGame
//
//  Created by Hanteo on 2021/03/18.
//

import UIKit
import VocaDesignSystem
import SnapKit

class ScoreAnimateView: UIView {
    enum Constant {
        enum Incorrect {
            static let duration: Double = 0.13
            static let image = UIImage(named: "imageFail")!
            static let shadow = Shadow(color: UIColor.orangered40, x: 0, y: 10, blur: 60)
        }
        enum Correct {
            static let duration: Double = 0.33
            static let image = UIImage(named: "imageSuccess")!
            static let shadow = Shadow(color: UIColor.goldenYellow40, x: 0, y: 10, blur: 60)
        }
    }
    
    enum ScoreType {
        case Incorrect
        case Correct
    }
    
    let scoreType: ScoreType
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    init(type: ScoreType) {
        scoreType = type
        super.init(frame: .zero)

        configureLayout()
        configureScoreStyle()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.centerY.equalTo(safeAreaLayoutGuide).offset(-10)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.width.height.equalTo(220)
        }
    }
    
    func configureScoreStyle() {
        switch scoreType {
        case .Correct:
            imageView.layer.shadow(Constant.Correct.shadow)
            imageView.image = Constant.Correct.image
        case .Incorrect:
            imageView.layer.shadow(Constant.Incorrect.shadow)
            imageView.image = Constant.Incorrect.image
        }
    }
}
