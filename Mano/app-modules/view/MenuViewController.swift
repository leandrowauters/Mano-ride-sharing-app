//
//  MenuViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 9/28/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let manuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = manuView
        // Do any additional setup after loading the view.
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissView() {
        dismiss(animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
