//
//  AlertViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 9/3/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

protocol AlertViewDelegate: AnyObject {
    func okayPressed()
}
class AlertViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    let titleMessage: String!
    let message: String?
    weak var delegate: AlertViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let message = message {
            messageLabel.text = message
        }
        titleLabel.text = titleMessage
    }

    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, title: String, message: String?) {
        self.titleMessage = title
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func okayPressed(_ sender: Any) {
        dismiss(animated: true)
        delegate?.okayPressed()
    }
    
}
