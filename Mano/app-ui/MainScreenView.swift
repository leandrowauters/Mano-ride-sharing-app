//
//  MainView.swift
//  Mano
//
//  Created by Leandro Wauters on 8/29/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit
import SnapKit


protocol MainScreenDelegate: AnyObject {
    func didPressedWhereTo(_: Bool)
}
class MainScreenView: UIView {
    
    public var isScheduleViewHiden = true
    weak var delegate: MainScreenDelegate?
    
    lazy var background: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    lazy var menuButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "menu"), for: .normal)
        return button
    }()
    
    lazy var menuView: UIView = {
       var view = UIView()
        view.backgroundColor = .clear
       view.layer.borderWidth = 1.5
        view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.isHidden = true
        return view
    }()
    
    //MENUVIEW SUBVIEWS
            lazy var editProfileButton: UIButton = {
                    var button = UIButton()
                    button.setImage(UIImage(named: "editProfileButton"), for: .normal)
                    button.contentHorizontalAlignment = .fill
                    button.contentVerticalAlignment = .fill
                    button.imageView?.contentMode = .scaleAspectFill
                    return button
            }()
    
            lazy var yourTripsButton: UIButton = {
                    var button = UIButton()
                    button.setImage(UIImage(named: "yourTripsButton"), for: .normal)
                    button.contentHorizontalAlignment = .fill
                    button.contentVerticalAlignment = .fill
                    button.imageView?.contentMode = .scaleAspectFill
                    return button
            }()
    
            lazy var settingsButton: UIButton = {
                    var button = UIButton()
                    button.setImage(UIImage(named: "settingsButton"), for: .normal)
                    button.contentHorizontalAlignment = .fill
                    button.contentVerticalAlignment = .fill
                    button.imageView?.contentMode = .scaleAspectFit
                    return button
            }()
    
    
    lazy var welcomeMessage: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 35)
        label.text = "Welcome"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var rideStatusView: UIView = {
        var view =  UIView()
        view.backgroundColor = .clear
        view.isHidden = false
        return view
    }()
    
            lazy var requestStatusLabel: UILabel = {
                    var label = UILabel()
                    label.text = "Ride(s) scheduled status:"
                    label.font = UIFont(name: "ArialRoundedMTBold", size: 25)
                    label.textColor = .white
                    label.textAlignment = .center
                    return label
            }()
    
            lazy var ridesCollectionView: UICollectionView = {
                    let layout = UICollectionViewFlowLayout()
                    layout.itemSize = CGSize.init(width: 340, height: 240)
                    layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
                    layout.scrollDirection = .horizontal
                    var collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
                    collectionView.backgroundColor = .clear
                    return collectionView
            }()
    
            lazy var smallerManoLogo: UILabel = {
                    var label = UILabel()
                    label.text = "Mano"
                    label.font = UIFont(name: "ArialRoundedMTBold", size: 45)
                    label.textColor = .white
                    label.textAlignment = .center
                    return label
            }()
    
    lazy var scheduleRideView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.3019607843, blue: 0.4431372549, alpha: 1)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner ]
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView()
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.style = .whiteLarge
        return activity
    }()
    
    lazy var scheduleRideButtonView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scheduleRideButtonPressed))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "scheduleRideIcon")
        return imageView
    }()
    
    lazy var scheduleRideLabel: UILabel = {
        var label = UILabel()
        label.text = "Schedule Ride"
        label.textColor = .white
        label.font =  UIFont(name: "ArialRoundedMTBold", size: 30)
        return label
    }()
    
    lazy var whereToView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.6754498482, blue: 0.9192627668, alpha: 1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(whereToPressed))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var whereToLabel: UIView = {
        var label = UILabel()
        label.text = "WhereTo"
        label.textColor = .white
        label.font =  UIFont(name: "ArialRoundedMTBold", size: 25)
        return label
    }()
    
    lazy var whereToImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "icons8-search_filled")
        return imageView
    }()
    
    lazy var pastTripsTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var noPreviousTripLabel: UILabel = {
        var label = UILabel()
        label.text = "No previous rides"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        addBackground()
        setupWelcomeMessage()
        setupMenuButton()
        setupManoLogo()
        setupMenuView()  
        setupRideStatus()
        setupScheduleView()
        setupActivityIndicator()
    }
    
    private func addBackground() {
        addSubview(background)
        background.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupMenuButton() {
        addSubview(menuButton)
        menuButton.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    private func setupMenuView() {
        addSubview(menuView)
        menuView.snp.makeConstraints { (make) in
            make.top.equalTo(menuButton.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalToSuperview().multipliedBy(0.25)
            make.leading.equalTo(15)
        }
    }
    
    
    private func setupScheduleView() {
        addSubview(scheduleRideView)
        scheduleRideView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            if isScheduleViewHiden{
            make.centerY.equalToSuperview().multipliedBy(1.5 + (5/6))
            } else {
            make.bottom.equalTo(2)
            }
            make.height.equalToSuperview().dividedBy(2)
            make.centerX.equalToSuperview()
            
        }
        
        let subViews = [scheduleRideButtonView, whereToView, pastTripsTableView, noPreviousTripLabel]
        
        subViews.forEach { (subView) in
            scheduleRideView.addSubview(subView)
        }
        setupScheduleRideButton()
        setupWhereToView()
//        scheduleRideButton.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalTo(scheduleRideView)
//            make.height.equalTo(scheduleRideView).dividedBy(6)
//        }




        pastTripsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(whereToView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        noPreviousTripLabel.snp.makeConstraints { (make) in
            make.center.equalTo(pastTripsTableView)
        }
        
    }
    
    private func setupScheduleRideButton() {
        scheduleRideButtonView.addSubview(scheduleRideLabel)
        scheduleRideButtonView.addSubview(imageView)
        
        scheduleRideButtonView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(scheduleRideView)
            make.height.equalTo(scheduleRideView).dividedBy(6)
        }
        scheduleRideLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(23)
            make.centerY.equalToSuperview()
        }
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(scheduleRideLabel)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.trailing.equalTo(-23)
        }
    }
    
    private func setupWhereToView() {
        whereToView.addSubview(whereToLabel)
        whereToView.addSubview(whereToImage)
        whereToView.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleRideButtonView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(scheduleRideView).dividedBy(7)
        }
        whereToLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(23)
            make.centerY.equalToSuperview()
        }
        whereToImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(whereToLabel)
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.trailing.equalTo(-23)
        }
    }
    
    private func setupWelcomeMessage() {
        addSubview(welcomeMessage)
        welcomeMessage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().multipliedBy(1.4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(30)
        }
    }
    
    private func setupManoLogo() {
        addSubview(smallerManoLogo)

    }
    
    private func setupRideStatus() {
        addSubview(rideStatusView)
        rideStatusView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.5)
        }
        let subViews = [ridesCollectionView,requestStatusLabel, smallerManoLogo]
        
        subViews.forEach { (subView) in
            rideStatusView.addSubview(subView)
        }
        
        smallerManoLogo.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        requestStatusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(smallerManoLogo.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        ridesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(requestStatusLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(rideStatusView.snp.bottom).offset(-5)
        }
    }
    
    func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    @objc func scheduleRideButtonPressed() {
        showScheduleRideView(isScheduleViewHiden)
    }
    
    func showScheduleRideView(_ isHidden: Bool) {
        if isHidden{
            UIView.animate(withDuration: 0.3) {
                self.scheduleRideView.frame.origin.y -= self.scheduleRideView.frame.height * (5/6)
            }
            isScheduleViewHiden = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.scheduleRideView.frame.origin.y += self.scheduleRideView.frame.height * (5/6)
            }
            isScheduleViewHiden = true
        }
    }

    @objc func whereToPressed() {
        delegate?.didPressedWhereTo(true)
    }
    
    private func locationWasSelected() {
        
    }
}
