//
//  CustomSearchBar.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class CustomSearchBar: UIView {
    
    // MARK: - Constants
    enum SearchType: String {
        case crew = "크루"
        case running = "러닝"
        case none
    }
    
    // MARK: - SubViews
    var backButton: UIButton!
    var eraseButton: UIButton!
    var searchButton: UIButton!
    var textField: UITextField!
    
    // MARK: - Properties
    @IBInspectable var barButtonItemSize: CGFloat = 20 {
        didSet {
            self.setupBarButtonConstraint()
        }
    }
    
    var isEmptyTextField: Bool = true {
        didSet {
            if self.isEmptyTextField {
                self.eraseButton.isHidden = true
            } else {
                self.eraseButton.isHidden = false
            }
        }
    }
    var delegate: CustomSearchBarDelegate?
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubview()
        self.setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.setBorder([ UIRectEdge.bottom ], width: 1, color: Color.symbol.cgColor)
    }
    
    // MARK: - Functions
    func setupSubview() {
        
        self.backButton = UIButton(frame: .zero)
        self.backButton.setImage(UIImage(named: AssetName.back), for: .normal)
        self.backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        
        self.eraseButton = CloseButton(frame: .zero)
        self.eraseButton.isHidden = true
        self.eraseButton.addTarget(self, action: #selector(eraseButtonPressed(_:)), for: .touchUpInside)
        
        self.searchButton = UIButton(frame: .zero)
        self.searchButton.setImage(UIImage(named: AssetName.search), for: .normal)
        self.searchButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside)
        
        self.textField = UITextField(frame: .zero)
        self.textField.addTarget(self, action: #selector(checkTextField(_:)), for: .editingChanged)
    }
    
    func setupConstraint() {
        
        let stackView = UIStackView(arrangedSubviews: [ self.backButton, self.textField, self.eraseButton, self.searchButton ])
        stackView.configure(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 20)
        
        self.addSubview(stackView)
        
        // setConstraint
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.eraseButton.translatesAutoresizingMaskIntoConstraints = false
        
        let heightAnchor = self.heightAnchor.constraint(equalToConstant: navigationBarHeight)
        
        let stackViewCenterYAnchor = stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let stackViewLeadingAnchor = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25)
        let stackViewTrailingAnchor = self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 25)
        
        NSLayoutConstraint.activate([
            heightAnchor,
            stackViewCenterYAnchor,
            stackViewLeadingAnchor,
            stackViewTrailingAnchor,
        ])
        
        self.setupBarButtonConstraint()
    }
    
    func setupBarButtonConstraint() {
        
        self.backButton.widthAnchor.constraint(equalToConstant: self.barButtonItemSize).isActive = true
        self.searchButton.widthAnchor.constraint(equalToConstant: self.barButtonItemSize).isActive = true
        self.searchButton.heightAnchor.constraint(equalToConstant: self.barButtonItemSize).isActive = true
        self.eraseButton.widthAnchor.constraint(equalToConstant: self.barButtonItemSize).isActive = true
        self.eraseButton.heightAnchor.constraint(equalToConstant: self.barButtonItemSize).isActive = true
    }
    
    func configure(searchType: SearchType) {
        
        self.textField.placeholder = "\(searchType.rawValue) 이름으로 검색"
    }
    
    @objc func checkTextField(_ sender: UITextField) {
        
        if self.textField.text == "" {
            self.isEmptyTextField = true
        } else {
            self.isEmptyTextField = false
        }
    }
    
    @objc func eraseButtonPressed(_ sender: UIButton) {
        
        self.textField.text = ""
        self.isEmptyTextField = true
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        self.delegate?.backButtonPressed()
    }
    
    @objc func searchButtonPressed(_ sender: UIButton) {
        
        guard let text = self.textField.text, text != "" else {
            debugPrint("입력 필요")
            return
        }
        
        self.delegate?.searchButtonPressed(wantToSearch: text)
    }
}
