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
    
    lazy var headerView: HomeHeaderView = {
        let view = HomeHeaderView(
            titles: Constant.headerTitle,
            activeTabType: currentTabType,
            delegate: self
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

extension HomeViewController: HomeHeaderDelegate {
    func homeHeader(_ view: HomeHeaderView, selectedTab: HomeTabType) {
        <#code#>
    }
    
    func homeHeader(_ view: HomeHeaderView, settingDidTap button: UIButton) {
        <#code#>
    }
}

extension HomeViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let viewController = previousViewControllers.first else {
            return
        }
        
        if viewController == myV
    }
}

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
}
