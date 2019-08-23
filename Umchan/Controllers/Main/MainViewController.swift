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
        Crew(name: "test1", numberOfPeople: 1, image: "test1"),
        Crew(name: "test2", numberOfPeople: 2, image: "test2"),
        Crew(name: "test3", numberOfPeople: 3, image: "test3"),
        Crew(name: "test4", numberOfPeople: 4, image: "test4"),
        Crew(name: "test5", numberOfPeople: 5, image: "test5"),
        Crew(name: "test6", numberOfPeople: 6, image: "test6"),
        Crew(name: "test7", numberOfPeople: 7, image: "test7"),
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
        
        self.navigationBar.configureButton(location: .right, type: .profile)
    }
    
    func setupSeoulMapView() {
        
        self.seoulMapView.setDistrictDelegate(self)
    }
    
    func setupCrewsView() {
        
        self.crewListView.configure(axis: .horizontal, distribution: .fillEqually, spacing: 10)
        
        for crew in self.crews {
            let crewView = CrewView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: self.crewListView.frame.height)))
            crewView.configure(crew: Crew(name: crew.name, numberOfPeople: crew.numberOfPeople, image: crew.image))
            
            self.crewListView.addArrangedSubview(crewView)
        }
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
