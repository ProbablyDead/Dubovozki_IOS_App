//
//  Appearance .swift
//  DubovozkiApp
//
//  Created by Илья Володин on 22.12.2023.
//

import UIKit

// MARK: - Appearance button cell view
final class AppearanceCell: UITableViewCell {
    static let reuseID: String = "AppearanceCell"
    
    private enum Constants {
        static let titleForCell: String = "Dark mode".localized()
        static let switchRightOffset: CGFloat = -13
    }
    
    private lazy var switchView: UISwitch = {
        let controller = UISwitch()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.addTarget(self, action: #selector(switched), for: .valueChanged)
        return controller
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var switchAction: ((Bool) -> Void)?
    
    @objc
    private func switched(_ sender: UISwitch) {
        if let switchAction = switchAction {
            switchAction(sender.isOn)
        }
    }
    
    public func configure(_ action: @escaping (Bool) -> Void, isDark: Bool? = nil) {
        if let isDark = isDark {
            switchView.setOn(isDark, animated: false)
        }
        switchAction = action
    }
    
    private func configureUI() {
        textLabel?.text = Constants.titleForCell
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        
        addSubview(switchView)
        
        switchView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchView.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.switchRightOffset).isActive = true
    }
}
