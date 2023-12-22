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
        
        static let navItemTitle: String = "Routes".localized()
    }
    
    private let routes: [Route] = Route.routes
    
    private lazy var arrangedCardViews: [RouteCardView] = routes.enumerated().map { (index, element) in
        let card = RouteCardView(title: element.name.localized(),
                                 travelTime: element.travelTime,
                                 backGroundImageName: element.imageName)
        
        card.tag = index
        card.tapHandler = showAdditional
        
        return card
    }
    
    private func showAdditional(for index: Int) {
        guard navigationController?.present(AdditionalViewController(routeCard: routes[index]), animated: true) != nil else { return }
    }
    
    private lazy var stackView: UIStackView = {
        let controller = UIStackView()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.distribution = .fillEqually
        controller.alignment = .fill
        controller.axis = .vertical
        controller.isUserInteractionEnabled = true
        controller.spacing = Constants.spacing
        
        arrangedCardViews.forEach { controller.addArrangedSubview($0) }
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        
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

