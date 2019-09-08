//
//  MapViewController+MapViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/31/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController: MapViewDelegate {
    
    func annotationButtonDelegate(isCheckMode: Bool) {
        
        self.isCheckMode = isCheckMode
        
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
    
    func answerAnnotationRemoveDelegate(didSelect view: MKAnnotationView) {
        
        let alertController = UIAlertController(title: "러닝포인트 삭제", message: "해당 러닝포인트를 코스에서 제외시키겠습니까?", preferredStyle: .alert)
        
        let removeActionHandler: (UIAlertAction) -> Void = { (action) in
            
            guard let runningPointView = view as? RunningPointAnnotationView else {
                debugPrint("err: fail to convert \(RunningPointAnnotationView.nibId)")
                return
            }
            
            guard let runningPoint = runningPointView.annotation as? RunningPoint else {
                debugPrint("err: fail to convert RunningPoint")
                return
            }
            
            let order = runningPoint.order - 1
            self.mapView.annotationList.remove(at: order)
            runningPointView.removeFromSuperview()
            
            self.mapView.reloadAnnotaionViews()
            
            self.mapView.clearRunningCourse()
            self.mapView.drawRunningCourse()
        }
        
        let removeAction = UIAlertAction(title: "예", style: .destructive, handler: removeActionHandler)
        let preserveAction = UIAlertAction(title: "아니오", style: .default, handler: nil)
        preserveAction.setValue(UIColor.blue, forKey: "titleTextColor")
        
        alertController.addAction(removeAction)
        alertController.addAction(preserveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
