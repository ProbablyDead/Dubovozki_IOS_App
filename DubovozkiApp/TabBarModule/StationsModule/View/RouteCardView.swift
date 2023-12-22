//
//  WayCardView.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 12.12.2023.
//

import UIKit

class RouteCardView: UIView {
    private enum Constants {
        static let textSize: CGFloat = 34
        static let cornerRadius: CGFloat = 15
        static let textOffset: CGFloat = 7
    }
    
    var tapHandler: ((Int) -> Void)?
    
    override var tag: Int {
        didSet {
            button.tag = tag
        }
    }
    
    @objc
    private func handleTap(_ sender: UIButton) {
        if let tapHandler = tapHandler {
            tapHandler(sender.tag)
        }
    }
    
    private lazy var button: UIButton = {
        let controller = UIButton()
        controller.backgroundColor = .clear
        controller.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.isUserInteractionEnabled = true
        return controller
    }()
    
    private let titleLabel: UILabel = {
        let controller = UILabel()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.textColor = .white
        controller.backgroundColor = .clear
        controller.font = .systemFont(ofSize: Constants.textSize)
        return controller
    }()
    
    private let travelTimeLabel: UILabel = {
        let controller = UILabel()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.textColor = .white
        controller.backgroundColor = .clear
        controller.font = .systemFont(ofSize: Constants.textSize)
        return controller
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let controller = UIImageView(frame: self.layer.bounds)
        controller.contentMode = .scaleToFill
        controller.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    init(title: String, travelTime: Int?, backGroundImageName: String) {
        self.titleLabel.text = title
        if let travelTime = travelTime {
            self.travelTimeLabel.text = "\(travelTime) " + "min".localized()
        }
        super.init(frame: .zero)
        
        if let image = UIImage(named: backGroundImageName) {
            backgroundImageView.image = image
        }
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        
        addSubview(button)
        addSubview(titleLabel)
        addSubview(travelTimeLabel)
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.textOffset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.textOffset).isActive = true
        
        travelTimeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.textOffset).isActive = true
        travelTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.textOffset).isActive = true
        
        backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let hitView = super.hitTest(point, with: event)
//        print("Hit Test: \(hitView)")
//        return hitView
//    }
}
