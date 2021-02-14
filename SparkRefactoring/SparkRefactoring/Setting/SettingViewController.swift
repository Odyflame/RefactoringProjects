//
//  SettingViewController.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/02/08.
//


import UIKit
import PoingVocaSubsystem
import PoingDesignSystem
import VocaGame
import SnapKit
import RxCocoa
import RxSwift

class SettingViewController: UIViewController {
    enum Constant {
        enum Title {
            static let font = UIFont.systemFont(ofSize: 26, weight: .bold)
            static let color = UIColor.midnight
            static let text = "설정"
        }
        enum Floating {
            static let height: CGFloat = 60
        }
    }
    
    var options: [Option] = []
    private let disposeBag = DisposeBag()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constant.Title.text
        label.font = Constant.Title.font
        label.textColor = Constant.Title.color
        return label
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btnCloseWhite"), for: .normal)
        button.layer.shadow(
            color: .greyblue20,
            alpha: 1,
            x: 0,
            y: 4,
            blur: 20,
            spread: 0
        )
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(closeButton(_:)), for: .touchUpInside)
        return button
    }()
    
//    lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .white
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.estimatedRowHeight = UITableView.automaticDimension
//        tableView.register(
//            SettingCell.self,
//            forCellReuseIdentifier: SettingCell.reuseIdentifier
//        )
//        tableView.register(
//            SettingMyInfoCell.self,
//            forCellReuseIdentifier: SettingMyInfoCell.reuseIdentifier
//        )
//        tableView.separatorStyle = .none
//        tableView.contentInset.bottom = Constant.Floating.height + (hasTopNotch ? bottomSafeInset : 32)
//        return tableView
//    }()
    
    @objc func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//extension SettingViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//}

extension SettingViewController: UITableViewDelegate {
}
