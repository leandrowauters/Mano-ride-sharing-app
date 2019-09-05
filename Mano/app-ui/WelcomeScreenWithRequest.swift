//
//  MainView.swift
//  Mano
//
//  Created by Leandro Wauters on 8/29/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit
import SnapKit

class MainScreenView: UIView {
    
    
    lazy var manoLogo: UILabel = {
       var label = UILabel()
        label.text = "Mano"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        return label
    }()
    
    lazy var requestStatusLabel: UILabel = {
        var label = UILabel()
        label.text = "Ride(s) scheduled status:"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        return label
    }()
    
    lazy var ridesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 225, height: 350)
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
        layout.scrollDirection = .horizontal
        //        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var scheduleRideView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.3019607843, blue: 0.4431372549, alpha: 1)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner ]
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    
    lazy var requestRideLabel: UILabel = {
        var label = UILabel()
        label.text = "Schedule ride:"
        label.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        return label
    }()
    
    lazy var whereToButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0.6754498482, blue: 0.9192627668, alpha: 1)
        button.setTitle("Where to?", for: .normal)
        button.setImage(UIImage(named: "scheduleRideIcon"), for: .normal)
        return button
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
