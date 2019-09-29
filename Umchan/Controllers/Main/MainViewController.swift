//
//  MainViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var seoulMapView: SeoulMapView!
    @IBOutlet weak var crewListView: UIStackView!
    @IBOutlet weak var districtPickerView: CustomPickerView!

    @IBOutlet weak var runningButton: UIButton!
    @IBOutlet weak var crewButton: UIButton!
    
    // MARK: - Properties
    let storyBoardName = "Main"
    
    var isLoggedIn: Bool = true
    var districts = [String]()

    enum MainSearchType {
        case running, crew
    }
    
    var searchType: MainSearchType = .running {
        didSet {
            if self.searchType == .running {
                self.runningButton.backgroundColor = Color.symbol
                self.runningButton.setTitleColor(.white, for: .normal)
                self.crewButton.backgroundColor = .white
                self.crewButton.setTitleColor(Color.symbol, for: .normal)
            } else {
                self.runningButton.backgroundColor = .white
                self.runningButton.setTitleColor(Color.symbol, for: .normal)
                self.crewButton.backgroundColor = Color.symbol
                self.crewButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLoggedIn {
            
            let stroyboard = UIStoryboard(name: StoryboardName.loginAndSignUp, bundle: nil)
            let viewController = stroyboard.viewController(LoginViewController.self)
            
            self.present(viewController, animated: true, completion: nil)
        } else {
            
            self.setup()
        }
    }
    
    // MARK: - Functions
    func setup() {

        self.setupNavigationBar()
        self.setupSeoulMapView()
        self.setupDistrictPickerView()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .right, type: .profile)
        self.navigationBar.configureBottomLineView(color: Color.symbol.cgColor, opacity: 0.5, radius: 0.1)
    }
    
    func setupSeoulMapView() {
        
        self.seoulMapView.setDistrictDelegate(self)
    }

    func setupDistrictPickerView() {

        self.districtPickerView.delegate = self
        self.districtPickerView.dataSource = self

        self.districts = DistrictInfoService.shared.districtCoordinates.map { $0.name ?? "" }
        self.districts.remove(at: 0)

        self.districtPickerView.reloadAllComponents()
    }

    func dismissSelfAndPresenetLogin() {

        let storyBoard = UIStoryboard(name: StoryboardName.loginAndSignUp, bundle: nil)
        let viewController = storyBoard.viewController(LoginViewController.self)

        self.tabBarController?.dismiss(animated: true, completion: nil)

        self.present(viewController, animated: true, completion: nil)
    }

    // MARK: - Actions
    @IBAction func goToRunButtonPressed(_ sender: Any) {

        let storyBoard = UIStoryboard(name: StoryboardName.registerRunning, bundle: nil)
        let viewController = storyBoard.viewController(RegisterRunningViewController.self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        self.present(navigationController, animated: true, completion: nil)
    }

    @IBAction func myRunningButtonPressed(_ sender: Any) {

        let storyBoard = UIStoryboard(name: StoryboardName.main, bundle: nil)
        let viewController = storyBoard.viewController(MyRunningsViewController.self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true

        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func searchCrewByName(_ sender: Any) {
        
        let viewController = SearchCrewViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func searchRunningByName(_ sender: Any) {
        
        let viewController = SearchRunningViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func unwindToMainViewController(_ segue: UIStoryboardSegue) {

        self.dismissSelfAndPresenetLogin()
    }

    @IBAction func runningButtonPressed(_ sender: UIButton) {
        self.searchType = .running
    }

    @IBAction func crewButtonPressed(_ sender: UIButton) {
        self.searchType = .crew
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

extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.districts.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.districts[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.seoulMapView.districtSelected(order: row)
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = view as? UILabel ?? UILabel()

        label.font = UIFont.umchanFont(size: CGFloat(22), boldState: .bold)!
        label.textColor = Color.symbol
        label.textAlignment = .center
        label.text = self.districts[row]

        return label
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(30)
    }
}
