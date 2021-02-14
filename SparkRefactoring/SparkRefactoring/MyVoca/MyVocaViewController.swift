//
//  MyVocaViewController.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/02/02.
//

import UIKit
import SnapKit
import AVFoundation
import Network
import RxSwift
import RxCocoa

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
    
    //var viewModel: MyVocaViewModelType
    
    //let vocaForAllViewModel: Voca
    let currentViewType: ViewType
    
    let disposeBag = DisposeBag()
    let synthesizer = AVSpeechSynthesizer()
    
    var currentSynthesizerCellRow: Int?
    var currentSynthesizerCellRowList: [Int] = []
    
    lazy var addWordFloatingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btnAdd"), for: .normal)
        button.layer.shadow(
            color: .brightSkyBlue50,
            alpha: 1,
            x: 0,
            y: 5,
            blur: 20,
            spread: 0
        )
        button.layer.masksToBounds = false
        return button
    }()

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
        configureLayout()
        configureMyVoca()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureLayout() {
        view.backgroundColor = .white
        
        //view.addSubview(groupNameCollectionView)

//        groupNameCollectionView.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            make.bottom.equalTo(view)
//        }
    }
    
    func configureMyVoca() {
        view.addSubview(addWordFloatingButton)
        view.addSubview(gameFloatingButton)

        addWordFloatingButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(hasTopNotch ? 0 : -16)
            make.centerX.equalTo(view)
            make.height.width.equalTo(Constant.Floating.height)
        }

        gameFloatingButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(hasTopNotch ? 0 : -16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.width.equalTo(Constant.Floating.height)
        }
    }
    
    func configureRx() {
        addWordFloatingButton.rx.tap
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
//                let viewController = TakePictureViewController()
//                let navigationController = UINavigationController(rootViewController: viewController)
//                navigationController.navigationBar.isHidden = true
//                navigationController.modalPresentationStyle = .fullScreen
//                navigationController.modalTransitionStyle = .coverVertical
//                self?.present(navigationController, animated: true, completion: nil)
            }).disposed(by: disposeBag)

        gameFloatingButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                let navigationController = UINavigationController(rootViewController: GameViewController())
                navigationController.navigationBar.isHidden = true
                navigationController.modalPresentationStyle = .fullScreen
                navigationController.modalTransitionStyle = .coverVertical
                self?.present(navigationController, animated: true, completion: nil)
            }).disposed(by: disposeBag)

//        viewModel.input.selectedFolder
//            .subscribe(onNext: { [weak self] (folders) in
//                guard folders != nil else { return }
//                self?.viewModel.input.getWord(page: self?.viewModel.input.currentPage.value ?? 0)
//                self?.groupNameCollectionView.reloadData()
//            }).disposed(by: disposeBag)
//
//        viewModel.output.folders
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] (_) in
//                self?.groupNameCollectionView.reloadData()
//
//            }).disposed(by: disposeBag)
//
//        viewModel.output.words
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] (_) in
//                self?.groupNameCollectionView.reloadData()
//            }).disposed(by: disposeBag)
    }
}
