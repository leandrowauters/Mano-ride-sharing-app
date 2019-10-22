//
//  MenuViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 9/28/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func hideMenu()
}
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    let manuView = MenuView()
    
    weak var delegate: MenuViewControllerDelegate?
    
    let options: [Options] = [.notifications,.messages,.editProfile,.settings,.signOut]
    override func viewDidLoad() {
        super.viewDidLoad()
        view = manuView
        manuView.delegate = self
        manuView.optionTableView.delegate = self
        manuView.optionTableView.dataSource = self
        manuView.optionTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissView() {
        dismiss(animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as?  MenuTableViewCell else {fatalError()}
        cell.configureCell(option: options[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MenuViewController: MenuScreenDelegate {
    func menuPressed() {
        delegate?.hideMenu()
    }
}
