//
//  SignOutButtonCell.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 11.12.2023.
//

import UIKit

// MARK: - Sign out button cell view
final class SignOutButtonCell: UITableViewCell {
    static let reuseID: String = "SignOutCell"
    
    private enum Constants {
        static let buttonName = "Sign out".localized()
    }
    
    private lazy var button: UIButton = {
        let controller = UIButton()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.setTitleColor(.systemRed, for: .normal)
        controller.setTitle(Constants.buttonName, for: .normal)
        controller.isUserInteractionEnabled = true
        controller.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        return controller
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var tapAction: (() -> ())?
    
    @objc
    private func signOutButtonTapped(_ sender: UIButton) {
        if let tapAction = tapAction {
            tapAction()
        }
    }
    
    public func configure(tapAction: @escaping () -> ()) {
        self.tapAction = tapAction
    }
    
    private func configureUI() {
        addSubview(button)
        
        contentView.isUserInteractionEnabled = false
        
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
