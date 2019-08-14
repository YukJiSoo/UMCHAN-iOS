//
//  SeoulMapView.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@IBDesignable
class SeoulMapView: UIView {
    var image: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.image = UIImage(named: "한강")
        image.contentMode = .scaleAspectFit
        
        
        self.addSubview(image)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let widthRatio = self.frame.width / 335
        let heightRatio = self.frame.height / 240
        
        image.frame = CGRect(x: 28 * widthRatio, y: 87 * heightRatio, width: (image.image?.size.width)! * widthRatio, height: (image.image?.size.height)! * heightRatio)
    }
    
    
    
}
