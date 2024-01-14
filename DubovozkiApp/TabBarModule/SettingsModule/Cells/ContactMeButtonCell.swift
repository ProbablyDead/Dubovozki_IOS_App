//
//  ContactMeButtonCell.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 14.01.2024.
//

import UIKit

// MARK: - Contact me button cell
class ContactMeButtonCell: UITableViewCell {
    static let reuseID: String = "ContactMeCell"
    
    private enum Constants {
        static let cellString: String = "Contact developer:".localized()
        static let rightOffsetConstant: CGFloat = -10
    }
    
    private let emailLabel: UILabel = {
        let controller = UILabel()
        controller.textColor = .systemBlue
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.backgroundColor = .clear
        controller.textAlignment = .right
        return controller
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        textLabel?.text = Constants.cellString
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        
        addSubview(emailLabel)
        
        emailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.rightOffsetConstant).isActive = true
    }
    
    public func configure(email: String) {
        emailLabel.text = email
    }
}
