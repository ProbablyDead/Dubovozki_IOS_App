//
//  AdditionalViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 22.12.2023.
//

import UIKit

class AdditionalViewController: UIViewController {
    private enum Constants {
        static let spacing: CGFloat = 5
        static let sideStackViewOffset: CGFloat = 5
        static let buttonName: String = "Open in maps".localized()
        static let buttonCornerRadius: CGFloat = 5
    }
    
    private enum LineMarkup {
        static let lineCornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 30
        static let lineY: CGFloat = 10
        static let lineHeight: CGFloat = 8
        static let tableOffset: CGFloat = 10
    }
    
    private lazy var line: UIView = {
        let rect = CGRect(x: view.center.x - LineMarkup.lineWidth/2,
                          y: LineMarkup.lineY,
                          width: LineMarkup.lineWidth,
                          height: LineMarkup.lineHeight)
        
        let controller = UIView(frame: rect)
        controller.backgroundColor = .systemGray3
        controller.layer.cornerRadius = LineMarkup.lineCornerRadius
        
        return controller
    }()
    
    private var cardTo: Station
    private var cardFrom: Station
    
    private lazy var cardToView: RouteCardView = {
        let controller = RouteCardView(title: self.cardTo.name.localized(), travelTime: nil, backGroundImageName: self.cardTo.imageName)
        return controller
    }()
    
    private lazy var buttonTo: UIButton = configureButton()
    
    private lazy var buttonFrom: UIButton = configureButton()
    
    private func configureButton() -> UIButton {
        let controller = UIButton()
        controller.setTitle(Constants.buttonName, for: .normal)
        controller.backgroundColor = .app
        controller.clipsToBounds = true
        controller.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        controller.layer.cornerRadius = Constants.buttonCornerRadius
        controller.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }
    
    @objc
    private func buttonPressed(_ sender: UIButton) {
        if sender == buttonTo {
            openLink(link: cardTo.linkToMaps)
        } else if sender == buttonFrom {
            openLink(link: cardFrom.linkToMaps)
        }
    }
    
    private func openLink(link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
    
    private lazy var cardFromView: RouteCardView = {
        let controller = RouteCardView(title: self.cardFrom.name, travelTime: nil, backGroundImageName: self.cardFrom.imageName)
        return controller
    }()
    
    private lazy var stackView: UIStackView = {
        let controller = UIStackView()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.distribution = .equalCentering
        controller.spacing = Constants.spacing
        controller.axis = .vertical
        controller.addArrangedSubview(cardToView)
        controller.addArrangedSubview(buttonTo)
        controller.addArrangedSubview(cardFromView)
        controller.addArrangedSubview(buttonFrom)
        
        return controller
    }()
    
    init(routeCard: Route) {
        self.cardTo = routeCard.stationTo
        self.cardFrom = routeCard.stationFrom
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        view.addSubview(line)
        
        stackView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: Constants.sideStackViewOffset).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideStackViewOffset).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sideStackViewOffset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
