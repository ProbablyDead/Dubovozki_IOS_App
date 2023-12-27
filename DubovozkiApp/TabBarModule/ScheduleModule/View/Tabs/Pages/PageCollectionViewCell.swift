//
//  PageCollectionViewCell.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 09.12.2023.
//

import UIKit

// MARK: - Paged view cell
class PageCollectionViewCell: UICollectionViewCell {
    public static let reuseID: String = "PagedCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    public var view: UIView? {
        didSet {
            configureUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        guard let view = view else { return }
        
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
