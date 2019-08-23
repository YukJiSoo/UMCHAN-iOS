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
    
    var dateFormatter: DateFormatter {
        
        return DateFormatter.basicFormatter(format: DateFormat.date, locale: DateFormat.locale)
    }
    
    var timeFormatter: DateFormatter {
        
        return DateFormatter.basicFormatter(format: DateFormat.time, locale: DateFormat.locale)
    }
    
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
        
        let dateString = self.dateFormatter.string(from: date)
        let timeString = self.timeFormatter.string(from: time)
        
        self.delegate?.datePicked(date: dateString, time: timeString)
        
        self.dismiss(animated: true, completion: nil)
    }
}
