//
//  DatePickerViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: CloseButton!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var delegate: DatePickerPresentable?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Functions
    func setup() {
    
        self.titleLabel.text = self.title
        self.closeButton.addTarget(self, action: #selector(self.closeButtonPressed(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        
        let date = self.dateDatePicker.date
        let time = self.timeDatePicker.date

        self.delegate?.datePicked(date: date, time: time)
        
        self.dismiss(animated: true, completion: nil)
    }
}
