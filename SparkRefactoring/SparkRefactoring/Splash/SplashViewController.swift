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
    
    func transitionToHome() {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        
        //let viewController = UINavigationController(rootViewController: )
    }
}
