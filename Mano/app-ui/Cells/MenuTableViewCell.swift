//
//  MenuTableViewCell.swift
//  Mano
//
//  Created by Leandro Wauters on 10/22/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

enum Options: String {
    case notifications
    case messages
    case editProfile
    case settings
    case signOut
}
class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(option: Options, notification: Bool) {
        //TO DO NOTIFICATION!
        var name = String()
        switch option {
        case .editProfile:
            name = "Edit Profile"
        case .signOut:
            name = "Sign Out"
        default:
            name = option.rawValue.capitalized
        }

        optionName.text = name
        optionImage.image = UIImage(named: option.rawValue) ?? UIImage()
    }
}
