//
//  SelectButtons.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 09.12.2023.
//

import UIKit

// MARK: - Select button
class SelectButton: UIButton {
    private enum Constants {
        static let buttonsCornerRadius: CGFloat = 5
        static let textLayoutOffset: CGFloat = 4
    }
    
    var changed: ((String) -> Void)!
    
    var currentSelection: String!
    
    private var options: [(String, String)]!
    
    init(opitions: [(String, String)], changed: @escaping (String) -> Void) {
        self.options = opitions
        self.changed = changed
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        setTitle(options![0].0, for: .normal)
        currentSelection = options![0].1
        
        let actionClosure = {[weak self] (action: UIAction) in
            self?.setTitle(action.title, for: .normal)
            self?.currentSelection = action.discoverabilityTitle
            self?.changed(action.discoverabilityTitle ?? "")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.label, for: .normal)
        layer.cornerRadius = Constants.buttonsCornerRadius
        contentHorizontalAlignment = .left
        backgroundColor = .systemBackground
        titleEdgeInsets = UIEdgeInsets(top: Constants.textLayoutOffset, left: Constants.textLayoutOffset,
                                       bottom: Constants.textLayoutOffset, right: Constants.textLayoutOffset)
        let menuChildren: [UIMenuElement] = self.options!.map {
            UIAction(title: $0.0, discoverabilityTitle: $0.1, handler: actionClosure)
        }
        
        menu = UIMenu(options: .displayInline, children: menuChildren)
        
        showsMenuAsPrimaryAction = true
    }
}
