//
//  p0-GameViewController.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/02/02.
//

import UIKit
import SnapKit
import VocaGame
import Pods_PoingVocaSubsystem
import PoingDesignSystem

class GameViewController: UIViewController {
    enum Constant {
        static let backgroundColor = UIColor.gameBackgroundColor
        static let gameList: [GameStyle] = [
            GameStyle(type: .flip, image: UIImage(named: "icnflip")),
            GameStyle(type: .matching, image: UIImage(named: "icnMatching"))
        ]
        static let spacing: CGFloat = 32
        enum Title {
            static let text = "함께 복습 해볼까요?"
            static let font = UIFont.systemFont(ofSize: 26, weight: .bold)
            static let textColor: UIColor = .midnight
        }
        enum Image {
            static let image = UIImage(named: "yellowFace")
            static let height: CGFloat = 130
        }
        enum Close {
            static let image = UIImage(named: "btnCloseWhite")
            static let height: CGFloat = 60
        }
    }
    
    var tableViewHeightConstraint: NSLayoutConstraint?
    
    lazy var guideContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var guideCenterContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = Constant.Image.image
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constant.Title.text
        label.font = Constant.Title.font
        label.textColor = Constant.Title.textColor
        label.textAlignment = .center
        return label
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gameListCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseIdentifier)
        collectionView.backgroundColor = Constant.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = false
        return collectionView
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constant.Close.image, for: .normal)
        button.addTarget(self, action: #selector(closeDidTap(_:)), for: .touchUpInside)
        button.layer.shadow(
            color: .cement20,
            alpha: 1,
            x: 0,
            y: 4,
            blur: 20,
            spread: 0
        )
        return button
    }()
    
    @objc func closeDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}



extension GameViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = Constant.gameList[indexPath.row]
        
        //let selectFolderViewController: VocaGame.sele
        //if ModeCon
    }
}


extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constant.gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseIdentifier, for: indexPath) as? GameCell else {
            return UICollectionViewCell()
        }
        cell.configure(Constant.gameList[indexPath.row])
        return cell
    }
}
