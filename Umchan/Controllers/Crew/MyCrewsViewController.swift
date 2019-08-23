//
//  MyCrewsViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MyCrewsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    
    // MARK: - SubViews
    var crewListView: ScrollableStackView?
    
    // MARK: - Properties
    var crews = [
        Crew(name: "test1", numberOfPeople: 1, image: "test1"),
        Crew(name: "test1", numberOfPeople: 1, image: "test1"),
        Crew(name: "test1", numberOfPeople: 1, image: "test1")
    ]
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Functions
    func setup() {
        
        self.setupNavigationBar()
        
        guard !crews.isEmpty else {
            self.setupEmptyCase()
            return
        }
        
        self.setupCrewListView()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.configureButton(location: .right, type: .profile)
    }
    
    func setupEmptyCase() {
        
        // add views
        let emptyImageView = UIImageView(frame: .zero)
        
        emptyImageView.image = UIImage(named: AssetName.empty)
        emptyImageView.contentMode = .scaleAspectFit
        
        let emptyLabel = UILabel(frame: .zero)
        
        emptyLabel.font = UIFont.umchanFont(size: CGFloat(20), boldState: .extrabold)
        emptyLabel.text = "참여중인 크루가 없습니다"
        emptyLabel.textColor = Color.symbolTransparent
        
        let createCrewButton = UIButton(frame: .zero)
        
        createCrewButton.setImage(UIImage(named: AssetName.shoes), for: .normal)
        createCrewButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        createCrewButton.setTitle("크루만들기", for: .normal)
        createCrewButton.titleLabel?.font = UIFont.umchanFont(size: CGFloat(20), boldState: .extrabold)
        createCrewButton.setTitleColor(Color.symbol, for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [ emptyImageView, emptyLabel, createCrewButton ])
        stackView.configure(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 30)
        self.view.addSubview(stackView)
        
        // setConstraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20).isActive = true
        
        let emptyImageViewWidthAnchor = emptyImageView.widthAnchor.constraint(equalToConstant: 200)
        let emptyImageViewHeightAnchor = emptyImageView.heightAnchor.constraint(equalToConstant: 200)

        let createCrewButtonWidthAnchor = createCrewButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)

        NSLayoutConstraint.activate([
            emptyImageViewWidthAnchor,
            emptyImageViewHeightAnchor,
            createCrewButtonWidthAnchor
        ])
    }
    
    func setupCrewListView() {
        
        let crewListView = ScrollableStackView(frame: .zero)
        
        var crewViews = [CrewView]()
        for crew in crews {
            let crewView = CrewView(frame: .zero)
            crewView.configure(crew: crew)
            
            crewViews.append(crewView)
        }
        
        crewListView.configureSubViews(subViews: crewViews)
        self.view.addSubview(crewListView)
        
        crewListView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = crewListView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor)
        let bottomAnchor = crewListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = crewListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = crewListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])
    }
    
}
