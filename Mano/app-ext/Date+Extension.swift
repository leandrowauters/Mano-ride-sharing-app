//
//  Date+Extension.swift
//  Mano
//
//  Created by Leandro Wauters on 9/1/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import Foundation

extension Date {
    var dateDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a yyyy"
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }
}
