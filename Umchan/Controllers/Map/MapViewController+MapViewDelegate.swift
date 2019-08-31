//
//  MapViewController+MapViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/31/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

extension MapViewController: MapViewDelegate {
    
    func annotationButtonDelegate(isCheckMode: Bool) {
        
        if isCheckMode {
            
            self.navigationBar.leftButton?.isHidden = true
            self.navigationBar.titleLabel.text = "거점을 모두 선택하셨으면 좌상단의 마크 버튼을 다시 눌러주세요"
            self.navigationBar.titleLabel.font = UIFont.umchanFont(size: 12, boldState: .bold)
            self.navigationBar.titleLabel.textColor = Color.symbolTransparent

            UIView.animate(
                withDuration: 0.3,
                delay: .zero,
                options: .transitionFlipFromTop,
                animations: {
                    
                    self.view.layoutIfNeeded()
            }, completion: nil)
            
            self.selectButton.setTitle("거점지 선택", for: .normal)
        } else {
            
            self.navigationBar.leftButton?.isHidden = false
            self.navigationBar.titleLabel.text = "코스선택"
            self.navigationBar.titleLabel.font = UIFont.umchanFont(size: 20, boldState: .bold)
            self.navigationBar.titleLabel.textColor = Color.symbol
            UIView.animate(
                withDuration: 0.3,
                delay: .zero,
                options: .transitionFlipFromTop,
                animations: {
                    
                    self.view.layoutIfNeeded()
            }, completion: nil)
            
            self.selectButton.setTitle("설정", for: .normal)
        }
    }
    
}
