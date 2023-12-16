//
//  ScheduleTableViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 09.12.2023.
//

import UIKit

class ScheduleTableView: UITableView {
    private enum Constants {
        static let cellHeight: CGFloat = UIScreen.main.bounds.height / 12
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        allowsSelection = false
        register(BusCell.self, forCellReuseIdentifier: BusCell.reuseID)
        self.delegate = self
    }
}

extension ScheduleTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}
