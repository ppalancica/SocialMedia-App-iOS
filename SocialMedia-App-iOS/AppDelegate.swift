//
//  AppDelegate.swift
//  SocialMedia-App-iOS
//
//  Created by Pavel Palancica on 10/1/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        
        let rootVC = RootViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)
        rootNC.isNavigationBarHidden = true
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootNC
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}
