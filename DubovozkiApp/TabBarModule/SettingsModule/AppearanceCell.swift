//
//  Appearance .swift
//  DubovozkiApp
//
//  Created by Илья Володин on 22.12.2023.
//

import UIKit

final class AppearanceCell: UITableViewCell {
    static let reuseID: String = "AppearanceCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .red
    }
}
