//
//  ModalViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/17/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController, ModalFirstViewable {
    
    // MARK: - SubViews
    var navigationBar = CustomNavigationBar(frame: .zero)
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupConstraints()
    }
    
    // MARK: - Functions
    func setTitle(_ title: String) {
        
        self.navigationBar.configureTitleLabel(with: title)
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
        self.view.addSubview(self.navigationBar)
    }
    
    func setupConstraints() {
        
        self.navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.navigationBar.heightAnchor.constraint(equalToConstant: navigationBarHeight).isActive = true
    }
    

}

extension ModalViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        
        self.closeButtonPressed(self.navigationBar)
    }
    
}

extension ModalViewController {
    
    class func viewController<T: ModalViewController>(_ type: T.Type, titleName: String) -> T {
        let viewController = T.init()
        
        viewController.modalPresentationStyle = .custom
        viewController.setTitle(titleName)
        
        return viewController
    }
}
