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
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with ride: Ride) {
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 15
        clipsToBounds = true
        rideDate.text = ride.appointmentDate
        addressLabel.text = ride.pickupAddress
        switch ride.rideStatus {
        case RideStatus.rideRequested.rawValue:
            rideStatusLabel.text = "Request status: Ride requested, waiting to find driver"
        case RideStatus.pickupAccepted.rawValue:
            rideStatusLabel.text = "Request status: Driver found!"
            
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
