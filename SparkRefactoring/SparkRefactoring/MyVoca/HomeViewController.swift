//
//  HomeViewController.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/01/22.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa

var hasTopNotch: Bool {
    return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
}

var bottomSafeInset: CGFloat {
    UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
}

enum HomeTabType: String {
    case myvoca = "나의 단어장"
    case vocaforall = "모두의 단어장"
}

class HomeViewController: UIViewController {
    enum Constant {
        static let headerTitle: [HomeTabType] = [HomeTabType.myvoca, HomeTabType.vocaforall]
        enum Floating {
            static let height: CGFloat = 60
        }
    }
    
    var disposebag = DisposeBag()
    var currentTabType: HomeTabType = .myvoca
    
}
