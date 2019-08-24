//
//  MainViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var seoulMapView: SeoulMapView!
    @IBOutlet weak var crewListView: UIStackView!
    
    // MARK: - Properties
    let storyBoardName = "Main"
//    var crews = [Crew]()
    var crews = [
        Crew(name: "test0", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test1", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test2", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test3", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test4", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0"),
        Crew(name: "test5", oneLine: "test0", creationDate: "test0", numberOfPeople: 9, image: "test0")
    ]
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupSeoulMapView()
        self.setupCrewsView()
    }
    
    // MARK: - Functions
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .right, type: .profile)
    }
    
    func setupSeoulMapView() {
        
        self.seoulMapView.setDistrictDelegate(self)
    }
    
    func setupCrewsView() {
        
        self.crewListView.configure(axis: .horizontal, distribution: .fillEqually, spacing: 10)
        
        for (index, crew) in self.crews.enumerated() {
            
            let crewView = CrewView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: self.crewListView.frame.height)))
            crewView.configure(crew: Crew(name: crew.name, oneLine: crew.oneLine, creationDate: crew.creationDate, numberOfPeople: crew.numberOfPeople, image: crew.image))
            
            crewView.tag = index
            crewView.isUserInteractionEnabled = true
            let tapCrewViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.crewViewTapped(_:)))
            crewView.addGestureRecognizer(tapCrewViewGesture)
            
            self.crewListView.addArrangedSubview(crewView)
        }
    }
    
    @objc func crewViewTapped(_ sender: UIGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: StoryboardName.crewInfo, bundle: nil)
        let viewController = storyboard.viewController(CrewInfoViewController.self)
        viewController.modalPresentationStyle = .custom
        
        if let tag = sender.view?.tag {
            viewController.crew = self.crews[tag]
        }
        self.present(viewController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func profileButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func goToRunButtonPressed(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: StoryboardName.registerRunning, bundle: nil)
        let viewController = storyBoard.viewController(RegisterRunningViewController.self)
        viewController.modalPresentationStyle = .custom
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func searchCrewByName(_ sender: Any) {
        
        let viewController = SearchCrewViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func searchRunningByName(_ sender: Any) {
        
        let viewController = SearchRunningViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension MainViewController: CustomNavigationBarDelegate {
    
    func rightBarButtonPressed(_ sender: UIButton) {
        
        let stroyboard = UIStoryboard(name: StoryboardName.profile, bundle: nil)
        let viewController = stroyboard.viewController(ProfileViewController.self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        self.present(navigationController, animated: true, completion: nil)
    }
}
