//
//  SplashViewController.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/03/17.
//

import UIKit
import RxSwift
import VocaSubsystem

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transitionToHome()
    }
    
    func transitionToHome() {
        let loginViewController = HomeViewController()

        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            print("왜 안돼지?")
          return
        }
        let navigationController = UINavigationController(rootViewController: loginViewController)
        window.rootViewController = navigationController
        
    }
}
