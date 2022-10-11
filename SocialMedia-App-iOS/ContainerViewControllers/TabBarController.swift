//
//  TabBarController.swift
//  SocialMedia-App-iOS
//
//  Created by Pavel Palancica on 10/1/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedVC = FeedViewController()
        feedVC.title = "Feed"
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: nil, tag: 0)
        
        let profileVC = ProfileViewController(delegate: self)
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 1)
        
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 2)
        
        let feedNC = UINavigationController(rootViewController: feedVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        
        viewControllers = [feedNC, profileNC, settingsNC]
    }
}

extension TabBarController: ProfileViewControllerDelegate {
    
    func didTapSignupOnSignupFlowEnterEmailView(controller: ProfileViewController) {
        
    }
    
    func didTapSigninOnSignupFlowEnterEmailView(controller: ProfileViewController) {
        
    }
}
