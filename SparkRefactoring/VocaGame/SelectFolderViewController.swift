//
//  SelectFolderViewController.swift
//  VocaGame
//
//  Created by Hanteo on 2021/02/04.
//

import UIKit
import PoingDesignSystem
import PoingVocaSubsystem
import SnapKit
import RxSwift
import RxCocoa

class SelectFolderViewController: UIViewController {

    enum Constant {
        static let spacing: CGFloat = 11
        enum Collection {
            static let topMargin: CGFloat = 44
        }
        enum Confirm {
            static let text = "복습하기"
            static let height: CGFloat = 60
            static let minWidth: CGFloat = 206
            enum Active {
                static let color: UIColor = .white
                static let backgroundColor: UIColor = .brightSkyBlue
            }
            enum InActive {
                static let color: UIColor = UIColor(white: 174.0 / 255.0, alpha: 1.0)
                static let backgroundColor: UIColor = .veryLightPink
            }
        }
    }
    
    lazy var navView: SideNavigationView = {
       let view = SideNavigationView(
        leftImage: UIImage(named: "icArrow"),
        centerTitle: "복습할 폴더 선택",
        rightImage: nil)
        view.leftSideButton.addTarget(self, action: #selector(closeDidTap(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var folderCollectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = Constant.spacing
        flowLayout.minimumLineSpacing = Constant.spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //collectionView.register(, forCellWithReuseIdentifier: <#T##String#>)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func closeDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
