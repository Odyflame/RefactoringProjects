//
//  AppDelegate.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/03/17.
//

import UIKit
import VocaSubsystem
//import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let splashViewController = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as UIViewController

        let viewController = splashViewController

        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()

        return true
    }

}

