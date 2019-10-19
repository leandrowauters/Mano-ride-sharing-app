//
//  ViewController+Extension.swift
//  Mano
//
//  Created by Leandro Wauters on 10/16/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func segueToMainVC(userId: String) {
        let mainViewVc = MainViewController(nibName: nil, bundle: nil, userId: userId)
        self.navigationController?.pushViewController(mainViewVc, animated: true)
    }
}
