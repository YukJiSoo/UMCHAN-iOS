//
//  SeoulMapView.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@IBDesignable
class SeoulMapView: UIView, NibLodable {
    
    // MARK: - Properties
    var distirctViews: [DistrictView] = []
    
    var widthRatio: CGFloat {
        return self.frame.width / ORIGINAL_MAP_WIDTH
    }
    
    var heightRatio: CGFloat {
        return self.frame.height / ORIGINAL_MAP_HEIGHT
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        for _ in 0..<DistrictInfoService.shared.districtCoordinatesCount {
            let districtView = DistrictView(frame: .zero)
            self.distirctViews.append(districtView)
            
            self.addSubview(districtView)
            
        }
        
        self.setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in 0..<DistrictInfoService.shared.districtCoordinatesCount {
            self.distirctViews[i].setLayout(self.widthRatio, self.heightRatio)
        }
    }
    
    // MARK: - Functions
    func setup() {
        
        let districts = DistrictInfoService.shared.districtCoordinates
        for i in 0..<DistrictInfoService.shared.districtCoordinatesCount {
            
            let district = districts[i]
            self.distirctViews[i].configure(with: district, self.widthRatio, self.heightRatio)
        }
    }
    
    func setDistrictDelegate(_ target: DistrictViewDelegate) {
        for districtView in self.distirctViews {
            districtView.delegate = target
        }
    }
    
}
