//
//  WayCardView.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 12.12.2023.
//

import UIKit

class WayCardView: UIView {
    private let imageView: UIImageView! = {
        let controller = UIImageView()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.contentMode = .scaleAspectFit
        controller.clipsToBounds = true
        return controller
    }()
    
    private let titleLabel: UILabel! = {
        let controller = UILabel()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.font = .systemFont(ofSize: 24)
        controller.backgroundColor = .clear
        return controller
    }()
    
    init(title: String, image: String) {
        if let image = UIImage(named: image) {
            imageView.image = image
        }
        titleLabel.text = title
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
