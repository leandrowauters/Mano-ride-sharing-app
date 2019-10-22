//
//  MenuView.swift
//  Mano
//
//  Created by Leandro Wauters on 9/9/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

protocol MenuScreenDelegate: AnyObject {
    func menuPressed()
}
class MenuView: UIView {

    weak var delegate: MenuScreenDelegate?
    
    lazy var optionTableView: UITableView = {
       var tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        return tableView
    }()
    
    lazy var menuButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "menuBlue"), for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupMenuButton()
        setupTableView()
    }
    
    private func setupMenuButton() {
        addSubview(menuButton)
                menuButton.addTarget(self, action: #selector(menuPressed), for: .touchUpInside)
        menuButton.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    private func setupTableView() {
        addSubview(optionTableView)
        optionTableView.snp.makeConstraints { (make) in
            make.top.equalTo(menuButton.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    @objc func menuPressed() {
        delegate?.menuPressed()
    }
}
