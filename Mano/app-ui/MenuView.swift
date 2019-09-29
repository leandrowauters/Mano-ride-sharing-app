//
//  MenuView.swift
//  Mano
//
//  Created by Leandro Wauters on 9/9/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class MenuView: UIView {

    lazy var menuView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    lazy var topView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.3019607843, blue: 0.4431372549, alpha: 1)
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    
            lazy var userImage: UIImageView = {
                    var imageView = UIImageView()
                    imageView.image = UIImage(named: "account")
                    return imageView
            }()
    
            lazy var userName: UILabel = {
                    var label = UILabel()
                    label.font = UIFont(name: "ArialRoundedMTBold", size: 17)
                    label.textColor = .white
                    label.textAlignment = .left
                    return label
            }()
    
    lazy var editView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var yourTripsView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var settingView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var messagesView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var editLabel: UIView = {
        var label = UILabel()
        label.text = "Edit Account"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var yourTripsLabel: UIView = {
        var label = UILabel()
        label.text = "Your Trips"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var settingsLabel: UIView = {
        var label = UILabel()
        label.text = "Settings"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var messagesLabel: UIView = {
        var label = UILabel()
        label.text = "Messages"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = #colorLiteral(red: 0.139659673, green: 0.1499087512, blue: 0.1619653702, alpha: 0)
        setupMenuView()
        setupTopView()
        setupImageView()
        setupUserName()
        setupEditView()
    }
    
    
    func setupMenuView() {
        addSubview(menuView)
        menuView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
    }
    func setupTopView() {
        menuView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(menuView.snp.top)
            make.leading.trailing.equalTo(menuView)
            make.height.equalTo(menuView).dividedBy(4)
        }
    }
    
    func setupImageView() {
        topView.addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.height.equalTo(topView).multipliedBy(0.8)
            make.width.equalTo(userImage)
            make.centerX.equalTo(topView)
            make.leading.equalTo(topView).inset(20)
        }
    }
    
    func setupUserName() {
        topView.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.centerX.equalTo(userImage).multipliedBy(0.8)
            make.leading.equalTo(-10)
            make.trailing.equalTo(-10)
        }
    }
    
    func setupEditView() {
        menuView.addSubview(editView)
        editView.addSubview(editLabel)
        
        editView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalTo(menuView)
            make.height.equalTo(menuView).dividedBy(7)
        }
        
        
        
    }
}
