//
//  ConteinerViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 10/19/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class ConteinerViewController: UIViewController {

    var menuViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func configureMainScreenVc() {
//        let mainVC = MainViewController()
//        view.addSubview()
    }

    func configureMenuVC() {
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
            print("Did add menu controller")
        }
    }
    
}
