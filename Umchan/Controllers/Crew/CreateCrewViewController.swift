//
//  CreateCrewViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class CreateCrewViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var crewNameTextField: UITextField!
    @IBOutlet weak var oneLineTextField: UITextField!
    @IBOutlet weak var districtPickerView: CustomPickerView!

    // MARK: - Properties
    var districts = [String]()

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGestureForEndEditting()
        self.setupNavigationBar()
        self.setupDistrictPickerView()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
    }

    func createCrewCompletion(_ response: Result<Bool, CrewAPIError>){

        switch response {
        case .success(_):

            let alertController = self.createBasicAlertViewController(title: "크루생성", message: "크루가 생성되었습니다.")  {
                self.dismiss(animated: true, completion: nil)
            }

            self.present(alertController, animated: true, completion: nil)
        case .failure(CrewAPIError.createCrew(let message)):

            self.presentFailAlertController("크루 생성 실패", with: message)
        default:
            debugPrint("Uncorrect access")
        }
    }

    func setupDistrictPickerView() {

        self.districtPickerView.delegate = self
        self.districtPickerView.dataSource = self

        self.districts = DistrictInfoService.shared.districtCoordinates.map { $0.name ?? "" }
        self.districts.remove(at: 0)

        self.districtPickerView.reloadAllComponents()
    }

    // MARK: - Actions
    @IBAction func createButtonPressed(_ sender: UIButton) {

        guard
            let name = self.crewNameTextField.text, !name.isEmpty,
            let oneLine = self.oneLineTextField.text, !oneLine.isEmpty
            else {
                debugPrint("All field is not filled")
                return
        }

        let disctrictSelectedIndex = self.districtPickerView.selectedRow(inComponent: 0)
        let district = self.districts[disctrictSelectedIndex]

        CrewService.shared.createCrew(
            name: name,
            oneLine: oneLine,
            district: district,
            completion: self.createCrewCompletion(_: )
        )
    }

}

extension CreateCrewViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateCrewViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.districts.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.districts[row]
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
