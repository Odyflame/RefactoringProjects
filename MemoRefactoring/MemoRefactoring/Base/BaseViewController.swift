//
//  BaseViewController.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/13.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

/**
 마진을 적용하기 위한 view controller라고 한다
 */
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        
        navigationController?.navigationBar.isHidden = true
        self.setupHideKeyboardOnTap()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(Constant.UI.Size.margin)
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-Constant.UI.Size.margin)
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(view.snp.top)
                make.leading.equalTo(view.snp.leading).offset(Constant.UI.Size.margin)
                make.trailing.equalTo(view.snp.trailing).offset(Constant.UI.Size.margin)
                make.bottom.equalTo(view)
            }
        }
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
