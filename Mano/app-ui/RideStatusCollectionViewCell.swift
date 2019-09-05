//
//  RideStatusCollectionViewCell.swift
//  Mano
//
//  Created by Leandro Wauters on 9/4/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class RideStatusCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rideDate: UILabel!
    @IBOutlet weak var rideStatusLabel: UILabel!
    @IBOutlet weak var pickupImage: UIImageView!
    @IBOutlet weak var pickupCheck: UIImageView!
    @IBOutlet weak var appointmentImage: UIImageView!
    @IBOutlet weak var appointmentCheck: UIImageView!
    @IBOutlet weak var dropoffCheck: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with ride: Ride) {
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 30
        clipsToBounds = true
        rideDate.text = ride.appointmentDate
        
        switch ride.rideStatus {
        case RideStatus.rideRequested.rawValue:
            changeAlpha(images: [pickupImage])
            rideStatusLabel.text = "Ride requested"
        case RideStatus.pickupAccepted.rawValue:
            rideStatusLabel.text = "Pick-up accepted"
            changeAlpha(images: [pickupImage,pickupCheck,appointmentImage])
        case RideStatus.dropoffAccepted.rawValue:
            rideStatusLabel.text = "Dropoff accepted"
            changeAlpha(images: [pickupImage,pickupCheck,appointmentImage, appointmentCheck, dropoffCheck])
        default:
            return
        }
    }
    
    func changeAlpha(images: [UIImageView]) {
        images.forEach { (image) in
            image.alpha = 1
        }
    }
    
}
