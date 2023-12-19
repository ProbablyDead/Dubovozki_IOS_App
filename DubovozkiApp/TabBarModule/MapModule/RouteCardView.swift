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
    
    init(title: String, travelTime: Int, backGroundImageName: String) {
        self.titleLabel.text = title
        self.travelTimeLabel.text = "\(travelTime) min"
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
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        
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
    }
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
