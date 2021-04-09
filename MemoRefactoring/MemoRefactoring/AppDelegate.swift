//
//  AppDelegate.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        // Override point for customization after application launch.
      self.window = UIWindow(frame: UIScreen.main.bounds)
        //    let coreData = CoreDataModel()
      let viewController = HomeViewController()
        //    viewController.insert(withModel: coreData)
      window?.rootViewController = UINavigationController(rootViewController: viewController)
      window?.makeKeyAndVisible()
      return true
    }
}

