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
        
        static let navItemName: String = "Routes"
        
        static let slavyanskiyTitle: String = Filters.station.slv.title
        static let slavyanskiyImageName: String = "slavyanskyBlvdEntry"
        
        static let molodejkaTitle: String = Filters.station.mld.title
        static let molodejkaImageName: String = "slavyanskyBlvdEntry"
        
        static let odintsovoTitle: String = Filters.station.odn.title
        static let odintsovoImageName: String = "slavyanskyBlvdEntry"
    }
    
    private lazy var slavyansky: WayCardView = WayCardView(title: Constants.slavyanskiyTitle, backGroundImageName: Constants.slavyanskiyImageName)
    private lazy var molodejnaya: WayCardView = WayCardView(title: Constants.molodejkaTitle, backGroundImageName: Constants.molodejkaImageName)
    private lazy var odintsovo: WayCardView = WayCardView(title: Constants.odintsovoTitle, backGroundImageName: Constants.odintsovoImageName)
    
    private lazy var arrangedCardViews: [UIView] = [self.slavyansky, self.molodejnaya, self.odintsovo]
    
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
        navigationItem.title = Constants.navItemName
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideStackViewOffset).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sideStackViewOffset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
}

