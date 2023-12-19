//
//  WayCardView.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 12.12.2023.
//

import UIKit

class WayCardView: UIView {
    private enum Constants {
        static let textSize: CGFloat = 34
        static let cornerRadius: CGFloat = 15
        static let textOffset: CGFloat = 7
    }
    
    private let titleLabel: UILabel = {
        let controller = UILabel()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.textColor = .white
        controller.backgroundColor = .clear
        controller.font = .systemFont(ofSize: Constants.textSize)
        return controller
    }()
    
    init(title: String, backGroundImageName: String) {
        self.titleLabel.text = title
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemPink
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        
        addSubview(titleLabel)
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.textOffset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.textOffset).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
