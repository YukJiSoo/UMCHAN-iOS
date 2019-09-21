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

        if let accessToken = Keychain.loadValue(for: "access_token") {
            print(accessToken)

            AuthService.shared.accessToken = accessToken
            let mainTabbarViewController = MainTabBarController()

            UserDataService.shared.loadUserData { (response) in

                switch response {
                case .success(_):
                    print("success")
                case .failure(.user(let message)):
                    print(message)
                default:
                    debugPrint("Uncorrect access")
                }
            }

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

