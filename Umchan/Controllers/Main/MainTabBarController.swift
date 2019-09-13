//
//  TabBarController.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myCrewsViewController = UIStoryboard(name: StoryboardName.main, bundle: nil).viewController(MyCrewsViewController.self)
        myCrewsViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AssetName.crew), tag: 0)
        myCrewsViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        
        let mainViewController = UIStoryboard(name: StoryboardName.main, bundle: nil).viewController(MainViewController.self)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.isNavigationBarHidden = true
        mainNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AssetName.main), tag: 1)
        mainNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        
        let runningHistoryListViewController = UIStoryboard(name: StoryboardName.main, bundle: nil).viewController(RunningHistoryListViewController.self)
        let runningHistoryNavigationController = UINavigationController(rootViewController: runningHistoryListViewController)
        runningHistoryNavigationController.isNavigationBarHidden = true
        runningHistoryNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AssetName.history), tag: 0)
        runningHistoryNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        
        let tabBarList = [myCrewsViewController, mainNavigationController, runningHistoryNavigationController]
        
        self.viewControllers = tabBarList
        self.selectedIndex = 1
    }

}
