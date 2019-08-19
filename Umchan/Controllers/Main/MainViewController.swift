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
    @IBOutlet weak var seoulMapView: SeoulMapView!
    @IBOutlet weak var contentView: UIStackView!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Functions
    func setup() {
        
        self.seoulMapView.setDistrictDelegate(self)
        
//        let hotCrewsView = CrewStackView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.contentView.frame.height))
//
//        self.contentView.addSubview(hotCrewsView)
        
        contentView.axis = .horizontal
        contentView.distribution = .fillEqually
        contentView.spacing = 1
        contentView.widthAnchor.constraint(equalToConstant: 500).isActive = true
        let a = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        a.backgroundColor = .blue
        contentView.addArrangedSubview(a)
        
        let b = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        b.backgroundColor = .red
        contentView.addArrangedSubview(b)
        
        let c = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        c.backgroundColor = .white
        contentView.addArrangedSubview(c)
        
        let d = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        d.backgroundColor = .black
        contentView.addArrangedSubview(d)
        
        let e = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        e.backgroundColor = .yellow
        contentView.addArrangedSubview(e)
        
        let f = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        f.backgroundColor = .cyan
        
        let g = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        g.backgroundColor = .black
        contentView.addArrangedSubview(g)
        
        let h = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.contentView.frame.height))
        h.backgroundColor = .white
        contentView.addArrangedSubview(h)
    }
    
    // MARK: - Actions
    @IBAction func profileButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func goToRunButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func searchCrewByName(_ sender: Any) {
        
    }
    
}
