//
//  TabView.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 09.12.2023.
//

import UIKit

class TabView: UIView, TabItemProtocol {
    private var title: String
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.backgroundColor = .clear
        label.textColor = .systemGray
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onSelected() {
        titleLabel.textColor = .label
        borderView.backgroundColor = .app
    }
    
    func onNotSelected() {
        titleLabel.textColor = .secondaryLabel
        borderView.backgroundColor = .clear
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        addSubview(borderView)
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        borderView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        borderView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        borderView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
