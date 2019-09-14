//
//  AppDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/6/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.tintColor = Color.symbol

        if Keychain.loadValue(for: "access_token") != nil {

            let mainTabbarViewController = MainTabBarController()

            self.window?.rootViewController = mainTabbarViewController
        } else {

            let storyBoard = UIStoryboard(name: StoryboardName.loginAndSignUp, bundle: nil)
            let initialViewController = storyBoard.viewController(LoginViewController.self)

            self.window?.rootViewController = initialViewController
        }

        self.window?.makeKeyAndVisible()
        
        return true
    }

}

