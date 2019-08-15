//
//  ModalViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - Actions
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
