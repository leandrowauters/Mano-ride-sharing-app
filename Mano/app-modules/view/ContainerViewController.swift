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
    var mainVC: MainViewController!
    var menuVC: MenuViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVC = MainViewController(nibName: nil, bundle: nil, userId: userId)
        configureMainScreenVc()
        // Do any additional setup after loading the view.
    }
    
    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 125
                
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
        
    }
 
    func configureMainScreenVc() {
        
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
            menuVC = MenuViewController()
            menuViewController = menuVC
            menuVC.delegate = self
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
                    menuVC.manuView.menuButton.isHidden = false
                    mainVC.mainScreenView.menuButton.isHidden = true
                }
        
                isExpanded = !isExpanded
                showMenuController(shouldExpand: isExpanded)
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func hideMenu() {
                if !isExpanded {
                    configureMenuVC()

                }
                isExpanded = !isExpanded
                showMenuController(shouldExpand: isExpanded)
                menuVC.manuView.menuButton.isHidden = true
                mainVC.mainScreenView.menuButton.isHidden = false
    }
}
