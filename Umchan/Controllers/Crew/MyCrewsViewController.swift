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
    var tableView = UITableView(frame: .zero)

    // MARK: - SubViews
    var crewListView: ScrollableStackView?
    let createCrewButton = UmchanCreateButtom(frame: .zero)

    var emptyView: UIStackView?

    // MARK: - Properties
    var crews: [CrewListQueryResult?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.removeFromSuperview()
                self.emptyView?.removeFromSuperview()
                
                if self.crews.isEmpty {
                    self.setupEmptyCase()
                } else {
                    self.setupXib()
                    self.setupTableView()
                }
            }
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.setupData()
    }
    
    // MARK: - Functions
    func setup() {
        
        self.setupNavigationBar()
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
                DispatchQueue.main.async {
                    self.setupEmptyCase()
                }
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

    func setupNavigationBar() {

        self.navigationBar.delegate = self
        
        self.navigationBar.configureButton(location: .right, type: .profile)
        self.navigationBar.configureButton(location: .left, type: .add)
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

        self.emptyView = stackView
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

    func setupTableView() {

        tableView.separatorStyle = .none

        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        let topAnchor = tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor, constant: 1)
        let bottomAnchor = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)

        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])


        let runningCellNib = UINib(nibName: RunningTableViewCell.nibId, bundle: nil)
        self.tableView.register(runningCellNib, forCellReuseIdentifier: RunningTableViewCell.nibId)

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.reloadData()
    }

    func setupXib() {

        let crewCellNib = UINib(nibName: CrewTableViewCell.nibId, bundle: nil)
        self.tableView.register(crewCellNib, forCellReuseIdentifier: CrewTableViewCell.nibId)
    }

}

extension MyCrewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.crews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CrewTableViewCell.nibId, for: indexPath) as? CrewTableViewCell else {
            debugPrint("err: fail to convert \(CrewTableViewCell.nibId)")
            return UITableViewCell()
        }

        guard let crew = self.crews[indexPath.row] else {
            debugPrint("Could not find post at row \(indexPath.row)")
            return UITableViewCell()
        }

        cell.configure(crew: crew)

        return cell
    }


}

extension MyCrewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: StoryboardName.crewInfo, bundle: nil)
        let viewController = storyboard.viewController(MyCrewViewController.self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true

        viewController.id = self.crews[indexPath.row]?.id
        viewController.district = self.crews[indexPath.row]?.district

        self.present(navigationController, animated: true, completion: nil)
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

    func leftBarButtonPressed(_ sender: UIButton) {

        let stroyboard = UIStoryboard(name: StoryboardName.createCrew, bundle: nil)
        let viewController = stroyboard.viewController(CreateCrewViewController.self)

        self.present(viewController, animated: true, completion: nil)
    }
}
