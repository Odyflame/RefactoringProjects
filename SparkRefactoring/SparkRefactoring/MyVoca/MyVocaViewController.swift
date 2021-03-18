//
//  MyVocaViewController.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/03/17.
//
import UIKit
import AVFoundation
import VocaSubsystem
import VocaDesignSystem
import RxSwift
import RxCocoa
import SnapKit

class MyVocaViewController: UIViewController {
    enum Constant {
        enum Floating {
            static let height: CGFloat = 60
        }
    }
    enum ViewType {
        case myVoca
        case vocaForAll
    }
    
    let currentViewType: ViewType
    let disposeBag = DisposeBag()
    
    lazy var gameFloatingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btnGame"), for: .normal)
        button.layer.shadow(
            color: .greyblue50,
            alpha: 1,
            x: 0,
            y: 5,
            blur: 20,
            spread: 0
        )
        button.layer.masksToBounds = false
        return button
    }()
    
    init(viewType: ViewType) {
        currentViewType = viewType
        
        if ModeConfig.shared.currentMode == .offline {
            //viewModel = MyVocaViewModel()
        } else {
            //viewModel = MyVocaOnlineViewModel()
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        switch currentViewType {
        case .myVoca:
            configureMyVoca()
            configureRx()
            
        case .vocaForAll:
            print("sdfsa")
        }
    }
    
    func configureMyVoca() {
        view.addSubview(gameFloatingButton)

        gameFloatingButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(hasTopNotch ? 0 : -16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.width.equalTo(Constant.Floating.height)
        }
    }
    
    func configureRx() {
        gameFloatingButton.rx.tap.subscribe(onNext: { [weak self] in
            //let viewController = UINavigationController(rootViewController: )
            
        }).disposed(by: disposeBag)
    }
}
