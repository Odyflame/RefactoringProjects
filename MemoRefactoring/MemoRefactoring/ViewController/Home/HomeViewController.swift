//
//  HomeViewController.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    enum HomeConstants {
      enum Table {
        static let EstimatedHeight: CGFloat = 100
        static let IdentifierWithImage: String = "CellWithImage"
        static let IdentifierWithoutImage: String = "CellWithoutImage"
      }
      enum AddButton {
        static let height: CGFloat = 48
        static let rightMargin: CGFloat = 8
        static let backgroundColor: UIColor = Color.veryLightGrey
        static let image: UIImage = UIImage(named: "addIcon")!
      }
    }
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private var viewModel: HomeViewModelType = HomeViewModel(coreData: CoreDataModel())
      
    override var preferredStatusBarStyle: UIStatusBarStyle {
      let theme = userPreferences.getColorTheme()
      if theme == .light {
        if #available(iOS 13.0, *) {
          return .darkContent
        } else {
          // Fallback on earlier versions
          return .default
        }
      } else {
        return .lightContent
      }
    }

}
