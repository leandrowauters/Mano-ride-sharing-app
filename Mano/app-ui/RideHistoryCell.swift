//
//  RideHistoryCell.swift
//  Mano
//
//  Created by Leandro Wauters on 9/28/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class RideHistoryCell: UITableViewCell {
    
    @IBOutlet weak var rideAddress: UILabel!
    @IBOutlet weak var rideDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(with ride: Ride) {
        rideAddress.text = ride.pickupAddress
        rideDate.text = ride.dateRequested
    }
}
