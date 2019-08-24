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
    let createCrewButton = UmchanCreateButtom(frame: .zero)
    
    // MARK: - Properties
    var crews = [
        Crew(name: "test0", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test1", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test2", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test3", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test4", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test5", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0")
    ]
//    var crews = [Crew]()
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Functions
    func setup() {
        
        self.setupNavigationBar()
        
        createCrewButton.setup(title: "크루만들기")
        createCrewButton.addTarget(self, action: #selector(createButtonPressed(_:)), for: .touchUpInside)
        
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
        crewListView.configureSubViews(subViews: [createCrewButton])
        
        self.view.addSubview(crewListView)
        
        crewListView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = crewListView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor)
        let bottomAnchor = crewListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = crewListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = crewListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])
    }
    
    @objc func createButtonPressed(_ sender: UIButton) {
        
        
        let storyBoard = UIStoryboard(name: StoryboardName.createCrew, bundle: nil)
        let viewController = storyBoard.viewController(CreateCrewViewController.self)
        
        viewController.modalPresentationStyle = .custom
        
        self.present(viewController, animated: true, completion: nil)
    }
}
