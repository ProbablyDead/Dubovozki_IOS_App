//
//  MapViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 05.12.2023.
//

import UIKit

class MapViewController: UIViewController {
    private enum Constants {
        static let sideStackViewOffset: CGFloat = 5
        static let spacing: CGFloat = 5
        
        static let navItemTitle: String = "Routes"
        
        static let slavyanskiyTitle: String = Filters.station.slv.title
        static let slavyanskiyTravelTime: Int = 30
        static let slavyanskiyImageName: String = "slavyanskyBlvdEntry"
        
        static let molodezhnayaTitle: String = Filters.station.mld.title
        static let molodezhnayaTravelTime: Int = 30
        static let molodezhnayaImageName: String = "molodezhnayaEntry"
        
        static let odintsovoTitle: String = Filters.station.odn.title
        static let odintsovoTravelTime: Int = 15
        static let odintsovoImageName: String = "odintsovoEntry"
    }
    
    private lazy var slavyansky: WayCardView = WayCardView(title: Constants.slavyanskiyTitle,
                                                           travelTime: Constants.slavyanskiyTravelTime,
                                                           backGroundImageName: Constants.slavyanskiyImageName)
    
    private lazy var molodezhnaya: WayCardView = WayCardView(title: Constants.molodezhnayaTitle,
                                                             travelTime: Constants.molodezhnayaTravelTime,
                                                            backGroundImageName: Constants.molodezhnayaImageName)
    private lazy var odintsovo: WayCardView = WayCardView(title: Constants.odintsovoTitle, travelTime: Constants.odintsovoTravelTime, backGroundImageName: Constants.odintsovoImageName)
    
    private lazy var arrangedCardViews: [UIView] = [self.slavyansky, self.molodezhnaya, self.odintsovo]
    
    private lazy var stackView: UIStackView = {
        let controller = UIStackView()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.distribution = .fillEqually
        controller.alignment = .fill
        controller.axis = .vertical
        controller.spacing = Constants.spacing
        
        arrangedCardViews.forEach { controller.addArrangedSubview($0) }
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
        
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideStackViewOffset).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sideStackViewOffset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = Constants.navItemTitle
    }
}

