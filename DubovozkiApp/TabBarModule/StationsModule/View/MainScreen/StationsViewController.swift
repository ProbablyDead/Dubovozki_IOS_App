//
//  MapViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 05.12.2023.
//

import UIKit

class StationsViewController: UIViewController {
    private enum Constants {
        static let sideStackViewOffset: CGFloat = 5
        static let spacing: CGFloat = 5
        
        static let navItemTitle: String = "Routes"
    }
    
    private let routes: [Route] = Route.routes
    
    private lazy var arrangedCardViews: [UIView] = routes.map { RouteCardView(title: $0.name,
                                                                              travelTime: $0.travelTime,
                                                                              backGroundImageName: $0.imageName) }
    
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

