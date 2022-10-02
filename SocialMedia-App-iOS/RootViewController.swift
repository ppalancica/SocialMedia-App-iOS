//
//  RootViewController.swift
//  SocialMedia-App-iOS
//
//  Created by Pavel Palancica on 10/1/22.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let nc = navigationController else { return }
        
        let tabBarController = TabBarController()
        nc.pushViewController(tabBarController, animated: false)
    }
}
