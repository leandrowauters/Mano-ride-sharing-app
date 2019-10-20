//
//  ConteinerViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 10/19/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    var menuViewController: UIViewController!
    var userId: String!
        var isExpanded = false
    var centerController: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainScreenVc()
        // Do any additional setup after loading the view.
    }
    
    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
        
    }
 
    func configureMainScreenVc() {
        let mainVC = MainViewController(nibName: nil, bundle: nil, userId: userId)
        mainVC.delegate = self
        let nav = UINavigationController(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        centerController = nav
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
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

extension ContainerViewController: MainViewControllerDelegate {
    func toggleMenu() {
                if !isExpanded {
                    configureMenuVC()
                }
        
                isExpanded = !isExpanded
                showMenuController(shouldExpand: isExpanded)
    }
    
    
}
