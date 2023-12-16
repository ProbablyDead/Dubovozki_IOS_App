//
//  TabCollectionViewCell.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 09.12.2023.
//

import UIKit

protocol TabItemProtocol: UIView {
    func onSelected()
    func onNotSelected()
}

class TabCollectionViewCell: UICollectionViewCell {
    static let reuseID: String = "TabCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var view: TabItemProtocol? {
        didSet {
            configureUI()
        }
    }
    
    private func configureUI() {
        guard let view = view else { return }
        
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        
        view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
