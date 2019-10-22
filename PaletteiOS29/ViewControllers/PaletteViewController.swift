//
//  PaletteViewController.swift
//  PaletteiOS29
//
//  Created by Christopher Alegre on 10/22/19.
//  Copyright © 2019 Chris Alegre. All rights reserved.

//STEP 1 - Declare Views
//STEP 2 - Add subviews to superview
//STEP 3 - Constrain Views

import UIKit

class PaletteViewController: UIViewController {
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var buttons: [UIButton] {
        return [featuredButton, doubleRainbowButton, randomButton]
    }
    
    var photos: [UnsplashPhoto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- API Functions
    func searchForCatogory(_ route: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: route) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else {return}
                self.photos = photos
                self.palleteTableView.reloadData()
            }
        }
    }
    
    //MARK:- Create Subview
    let featuredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Random", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Double Rainbow", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let buttonStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        return stackView
    }()
    
    let palleteTableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    //MARK:- Add Subviews
    func addAllSubviews() {
        self.view.addSubview(featuredButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(palleteTableView)
    }
    
    func setUpStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        buttonStackView.addArrangedSubview(randomButton)
    }
    
    func configureTableView() {
        palleteTableView.delegate = self
        palleteTableView.dataSource = self
        palleteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "paletteCell")
        palleteTableView.allowsSelection = false
    }
    
    //MARK:- Constrain Views
    func constrainView() {
        palleteTableView.ancor(top: buttonStackView.bottomAnchor, bottom: self.safeArea.bottomAnchor, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, topPadding: (buttonStackView.frame.height/2), bottomPadding: 0, leadingPadding: 0, trailingPaddding: 0)
        
        buttonStackView.ancor(top: self.safeArea.topAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 8, trailingPaddding: 8)
    }
    
    //MARK:- Actions
    func activateButtons() {
        buttons.forEach{ $0.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)}
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        selectButton(sender)
        switch sender {
        case randomButton:
            searchForCatogory(.random)
        case doubleRainbowButton:
            searchForCatogory(.doubleRainbow)
        case featuredButton:
            searchForCatogory(.featured)
        default:
            fatalError()
        }
    }
    
    func selectButton(_ button: UIButton) {
        buttons.forEach{ $0.setTitleColor(UIColor(named: "offWhite"), for: .normal)}
        button.setTitleColor(UIColor(named: "devMountainBlue"), for: .normal)
    }
}

//MARK:- TableView Conformance
extension PaletteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paletteCell", for: indexPath) as? PaletteTableViewCell
            else {return UITableViewCell()}
        
        let photo = photos[indexPath.row]
        cell.photo = photo
        
        return cell
    }
}
