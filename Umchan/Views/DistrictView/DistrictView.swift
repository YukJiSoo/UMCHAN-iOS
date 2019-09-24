//
//  DistrictView.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class DistrictView: UIImageView {
    
    // MAKRK: - Properties
    // json에 저장되어 있는 original x, y 값
    var originX: CGFloat?
    var originY: CGFloat?
    var name: String?
    
    @IBInspectable var districtColor: UIColor {
        return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
    @IBInspectable var riverColor: UIColor {
        return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    var delegate: DistrictViewDelegate?
    
    // MAKRK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MAKRK: - Functions
    func configure(with disritct: DistrictCoordinate, _ widthRatio: CGFloat, _ heightRatio: CGFloat, isSelected: Bool = false) {
        guard let name = disritct.name, var image = UIImage(named: name) else {
            debugPrint("err: fail convert image")
            return
        }

        guard let x = disritct.x else {
            debugPrint("err: fail convert x")
            return
        }
        
        guard let y = disritct.y else {
            debugPrint("err: fail convert y")
            return
        }
        
        self.name = name
        self.originX = CGFloat(x)
        self.originY = CGFloat(y)

        // set now district another color
        if isSelected {
            image = UIImage(named: "\(name)select")!
            self.setGestureRecognizer()
        }

        self.image = image
        self.contentMode = .scaleAspectFit
        
        self.setLayout(widthRatio, heightRatio)
    }
    
    func setLayout(_ widthRatio: CGFloat, _ heightRatio: CGFloat) {
        guard let x = self.originX, let y = self.originY, let image = self.image else {
            debugPrint("err: x or y is nil")
            return
        }
        
        let xCoordinate = CGFloat(x) * widthRatio
        let yCoordinate = CGFloat(y) * heightRatio
        let width = image.size.width * widthRatio
        let height = image.size.height * heightRatio
        
        self.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        
    }
    
    func setGestureRecognizer() {

        self.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(districtPressed(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func districtPressed(_ sender: Any) {
        
        if let name = self.name {
            self.delegate?.districtView(selectedDistrict: name)
        } else {
            debugPrint("err: name is nil")
        }
    }
    
}
