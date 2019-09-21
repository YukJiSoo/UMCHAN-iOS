//
//  MyCrewsViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MyCrewsViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    
    // MARK: - SubViews
    var crewListView: ScrollableStackView?
    let createCrewButton = UmchanCreateButtom(frame: .zero)
    
    // MARK: - Properties
    var crews: [CrewListQueryResult]? {
        didSet {
            DispatchQueue.main.async {
                guard let crews = self.crews else {
                    return
                }

                if crews.isEmpty {
                    self.setupEmptyCase()
                } else {
                    self.setupCrewListView()
                }
            }
        }
    }
    
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

        self.setupData()
    }

    func setupData() {

        CrewService.shared.crewList { (response) in
            switch response {
            case .success(_):

                guard let data = try? response.get() else {
                    debugPrint("cannot get data")
                    return
                }

                self.crews = data
            case .failure(CrewAPIError.crewList(let message)):

                print(message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

    func setupNavigationBar() {

        self.navigationBar.delegate = self
        
        self.navigationBar.configureButton(location: .right, type: .profile)
        self.navigationBar.configureBottomLineView(color: Color.symbol.cgColor, opacity: 0.5, radius: 0.1)
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

        guard let crews = self.crews else {
            debugPrint("Fail: binding crew array")
            return
        }

        for (index, crew) in crews.enumerated() {
            let crewView = CrewView(frame: .zero)
            crewView.configure(crew: crew)

            crewView.tag = index
            crewView.isUserInteractionEnabled = true
            let tapCrewViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.crewViewTapped(_:)))
            crewView.addGestureRecognizer(tapCrewViewGesture)

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

    @objc func crewViewTapped(_ sender: UIGestureRecognizer) {

        let storyboard = UIStoryboard(name: StoryboardName.crewInfo, bundle: nil)
        let viewController = storyboard.viewController(CrewInfoViewController.self)
        viewController.modalPresentationStyle = .custom

        if let tag = sender.view?.tag, let crews = self.crews {
            viewController.crew = crews[tag]
        }
        self.present(viewController, animated: true, completion: nil)
    }

    @objc func createButtonPressed(_ sender: UIButton) {
        
        
        let storyBoard = UIStoryboard(name: StoryboardName.createCrew, bundle: nil)
        let viewController = storyBoard.viewController(CreateCrewViewController.self)
        
        viewController.modalPresentationStyle = .custom
        
        self.present(viewController, animated: true, completion: nil)
    }
}

extension MyCrewsViewController: CustomNavigationBarDelegate {

    func rightBarButtonPressed(_ sender: UIButton) {

        let stroyboard = UIStoryboard(name: StoryboardName.profile, bundle: nil)
        let viewController = stroyboard.viewController(ProfileViewController.self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true

        self.present(navigationController, animated: true, completion: nil)
    }
}
