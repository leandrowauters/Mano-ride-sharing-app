//
//  RideDetailViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 9/5/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class RideDetailViewController: UIViewController {
    
    private var pickupAddresss: String!
    private var appointmentAddress: String!
    private var dropoffAddress: String!
    private var date: String!
    
    @IBOutlet weak var pickupAddress: UILabel!
    @IBOutlet weak var appointmentAddressLabel: UILabel!
    @IBOutlet weak var dropoffAddressLabel: UILabel!
    @IBOutlet weak var cancelRideView: BorderView!
    @IBOutlet weak var editRideView: BorderView!
    @IBOutlet weak var concatcDriverView: BorderView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTaps()
        setup()
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, pickupAddress: String, appointmentAddress: String, dropoffAddress: String, date: String) {
        self.pickupAddresss = pickupAddress
        self.appointmentAddress = appointmentAddress
        self.dropoffAddress = dropoffAddress
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        pickupAddress.text = pickupAddresss
        appointmentAddressLabel.text = appointmentAddress
        dropoffAddressLabel.text = dropoffAddress
        dateLabel.text = date
    }
    func setupTaps() {
        let contactTap = UITapGestureRecognizer(target: self, action: #selector(contactDriverPressed))
        let cancelRideTap = UITapGestureRecognizer(target: self, action: #selector(cancelRidePressed))
        let editRideTap = UITapGestureRecognizer(target: self, action: #selector(editRidePressed))
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        concatcDriverView.addGestureRecognizer(contactTap)
        cancelRideView.addGestureRecognizer(cancelRideTap)
        editRideView.addGestureRecognizer(editRideTap)
        view.addGestureRecognizer(dismissTap)
        
        
    }
    
    @objc func contactDriverPressed() {
       print("Contact Driver")
    }
    
    @objc func editRidePressed() {
       print("Edit")
    }
    
    @objc func cancelRidePressed() {
       print("Cancel")
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
