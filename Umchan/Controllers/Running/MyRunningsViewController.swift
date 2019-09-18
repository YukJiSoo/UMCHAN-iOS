//
//  MyRunningsViewController.swift
//  Umchan
//
//  Created by 육지수 on 9/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MyRunningsViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!

    // MARK: - SubViews
    var tableView: UITableView?

    // MARK: - Properties
//    var runnings = [Running]()
    var runnings: [RunningListQueryType]? {
        didSet {
            DispatchQueue.main.async {
                guard let runnings = self.runnings else {
                    return
                }

                if runnings.isEmpty {
                    self.setupEmptyCase()
                } else {
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

    // MARK: - Functions
    func setup() {

        self.setupNavigationBar()
        self.setupData()
    }

    func setupData() {

        RunningService.shared.runningList { (response) in

            switch response {
            case .success(_):

                guard let data = try? response.get() else {
                    debugPrint("cannot get data")
                    return
                }

                self.runnings = data
            case .failure(RunningAPIError.runningList(let message)):

                print(message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }
    
    func setupNavigationBar() {

        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
    }

    func setupEmptyCase() {

        // add views
        let emptyImageView = UIImageView(frame: .zero)

        emptyImageView.image = UIImage(named: AssetName.empty)
        emptyImageView.contentMode = .scaleAspectFit

        self.view.addSubview(emptyImageView)

        let emptyLabel = UILabel(frame: .zero)

        emptyLabel.font = UIFont.umchanFont(size: CGFloat(20), boldState: .extrabold)
        emptyLabel.text = "참가 예정인 러닝이 없습니다"
        emptyLabel.textColor = Color.symbolTransparent

        self.view.addSubview(emptyLabel)

        // set Constraint
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false

        let emptyImageViewCenterXAnchor = emptyImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let emptyImageViewCenterYAnchor = emptyImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let emptyImageViewWidthAnchor = emptyImageView.widthAnchor.constraint(equalToConstant: 200)
        let emptyImageViewHeightAnchor = emptyImageView.heightAnchor.constraint(equalToConstant: 200)

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        let emptyLabelTopAnchor = emptyLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 30)
        let emptyLabelCenterXAnchor = emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)

        NSLayoutConstraint.activate([
            emptyImageViewCenterXAnchor,
            emptyImageViewCenterYAnchor,
            emptyImageViewWidthAnchor,
            emptyImageViewHeightAnchor,
            emptyLabelTopAnchor,
            emptyLabelCenterXAnchor
            ])
    }

    func setupTableView() {

        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none

        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        let topAnchor = tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor)
        let bottomAnchor = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)

        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])

        self.tableView = tableView

        let runningCellNib = UINib(nibName: RunningTableViewCell.nibId, bundle: nil)
        self.tableView?.register(runningCellNib, forCellReuseIdentifier: RunningTableViewCell.nibId)

        self.tableView?.delegate = self
        self.tableView?.dataSource = self

        self.tableView?.reloadData()
    }

}

extension MyRunningsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.runnings?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: RunningTableViewCell.nibId, for: indexPath) as? RunningTableViewCell else {
            debugPrint("err: fail to convert \(RunningTableViewCell.nibId)")
            return UITableViewCell()
        }

        guard let running = self.runnings?[indexPath.row] else {
            fatalError("Could not find post at row \(indexPath.row)")
        }

        cell.configure(running: running)

        return cell
    }


}

extension MyRunningsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: StoryboardName.running, bundle: nil)
        let viewController = storyboard.viewController(RunningViewController.self)

        if let runnings = self.runnings {
            viewController.id = runnings[indexPath.row].id
        }

        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MyRunningsViewController: CustomNavigationBarDelegate {

    func leftBarButtonPressed(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
    }
}
