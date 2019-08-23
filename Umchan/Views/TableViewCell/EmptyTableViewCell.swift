//
//  EmptyTableViewCell.swift
//  Umchan
//
//  Created by 육지수 on 8/22/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell, NibLodable {

    enum ButtonState {
        case running, crew
    }
    
    // MARK: - Outlets
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(stateText: String, state: ButtonState) {
        
        self.stateLabel.text = stateText
        
        switch state {
        case .running:
            self.createButton.setTitle("달리러가기", for: .normal)
        case .crew:
            self.createButton.setTitle("크루만들기", for: .normal)
        }
    }
    
}
