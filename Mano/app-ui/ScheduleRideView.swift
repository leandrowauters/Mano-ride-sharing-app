//
//  ScheduleRideView.swift
//  Mano
//
//  Created by Leandro Wauters on 9/1/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

protocol ScheduleRideViewDelegate: AnyObject {
    func scheduleRidePressed()
    func selectDatePressed()
    func cancelRidePressed()
    func didChangeDate()
}
class ScheduleRideView: UIView {

    lazy var mapView = MKMapView()

    weak var delegate: ScheduleRideViewDelegate?
    
    lazy var scheduleRideView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.3019607843, blue: 0.4431372549, alpha: 1)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner ]
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    lazy var scheduleRideButtonView: UIView = {
       var view = UIView()
        view.backgroundColor = .clear
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
                label.font =  UIFont(name: "ArialRoundedMTBold", size: 30)
                label.textColor = .white
                return label
            }()
    

    
    lazy var selectDateView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectDatePressed))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
            lazy var selectDateImage: UIImageView = {
                    var imageView = UIImageView()
                    imageView.image = UIImage(named: "calendar")
                    return imageView
            }()
    
            lazy var selectDateLabel: UIView = {
                    var label = UILabel()
                    label.text = "Select Date"
                    label.font =  UIFont(name: "ArialRoundedMTBold", size: 30)
                    label.textColor = .white
                    return label
            }()
    
    lazy var roundTripLabel: UILabel = {
       var label = UILabel()
        label.text = "Round Trip?"
        label.textColor = .white
        label.font =  UIFont(name: "ArialRoundedMTBold", size: 30)
        return label
    }()
    
    lazy var roundTripSwitch: UISwitch = {
        var roundTripSwitch = UISwitch()
        roundTripSwitch.isOn = true
        return roundTripSwitch
    }()
    
    lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.backgroundColor = .clear
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        return datePicker
    }()
    lazy var cancelButton = RoundedButton()

    lazy var requestButton = RoundedButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
       
        setupMap()
        setupScheduleView()
    }
    
    private func setupMap() {
        addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
        }
    }
    private func setupScheduleView() {
        addSubview(scheduleRideView)
        scheduleRideView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalTo(2)
            make.height.equalToSuperview().dividedBy(2)
            make.centerX.equalToSuperview()
        }
        
        let subViews = [scheduleRideButtonView, selectDateView, roundTripSwitch, roundTripLabel, cancelButton, requestButton]
        subViews.forEach { (subView) in
            addSubview(subView)
        }
        setupScheduleRideButton()
        setupSelectDateView()
        setupRoundTripLabel()
        setupRoundTripSwitch()
        setupCancelButton()
        setupRequestButton()
        setupDatePicker()
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

    
    private func setupSelectDateView() {
        selectDateView.addSubview(selectDateLabel)
        selectDateView.addSubview(selectDateImage)
        selectDateView.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleRideButtonView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(scheduleRideView).dividedBy(6)
        }
        selectDateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(23)
            make.centerY.equalToSuperview()
        }
        
        selectDateImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(selectDateLabel)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.trailing.equalTo(-23)
        }
        
    }
    
    private func setupRoundTripLabel() {
        roundTripLabel.snp.makeConstraints { (make) in
            make.top.equalTo(selectDateView.snp.bottom).inset(-25)
            make.leading.equalTo(23)
        }
    }
    
    private func setupRoundTripSwitch() {
        roundTripSwitch.snp.makeConstraints { (make) in
            make.trailing.equalTo(-23)
            make.centerY.equalTo(roundTripLabel)
        }
    }
    
    private func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = #colorLiteral(red: 0.995932281, green: 0.2765177786, blue: 0.3620784283, alpha: 1)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.leading.equalTo(23)
            make.trailing.equalTo(-23)
            make.top.equalTo(roundTripLabel.snp.bottom).inset(-55)
//            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(scheduleRideView).dividedBy(7.5)
        }
    }
    
    private func setupRequestButton() {
        requestButton.isHidden = true
        requestButton.addTarget(self, action: #selector(scheduleRidePressed), for: .touchUpInside)
        requestButton.setTitle("Request", for: .normal)
        requestButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        requestButton.setTitleColor(.white, for: .normal)
        requestButton.backgroundColor = #colorLiteral(red: 0, green: 0.7077997327, blue: 0, alpha: 1)
        requestButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(-23)
            make.top.equalTo(roundTripLabel.snp.bottom).inset(-55)
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(scheduleRideView).dividedBy(7.5)
        }
    }
    
    private func setupDatePicker() {
        datePicker.isHidden = true
        addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.trailing.leading.equalTo(scheduleRideView)
            make.height.equalTo(scheduleRideView).dividedBy(1.6)
            make.bottom.equalTo(roundTripLabel.snp.top)
        }
    }
    
    @objc func scheduleRidePressed() {
        delegate?.scheduleRidePressed()
    }
    
    
    @objc func selectDatePressed() {
        delegate?.selectDatePressed()
    }
    
    @objc func cancelPressed() {
        delegate?.cancelRidePressed()
    }
    
    @objc func didChangeDate() {
        delegate?.didChangeDate()
    }
}

