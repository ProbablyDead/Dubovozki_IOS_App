//
//  SettingsModuleViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 05.12.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    private enum Constants {
        static let navItemTitle: String = "Settings"
        static let signOutButtonTitle: String = "Sign out"
        static let numberOfItemsInMainSection: Int = 1
        static let numberOfItemsInSignOutSection: Int = 1
        static let numberOfSections: Int = 2
    }
    
    private let appearanceSettings = AppearanceSaving()
    
    var loginService: LoginServiceProtocol?
    var router: RouterProtocol?
    
    private let settingsTable: UITableView = {
        let controller = UITableView()
        controller.backgroundColor = .secondarySystemBackground
        controller.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(settingsTable)
        settingsTable.delegate = self
        settingsTable.dataSource = self
        
        settingsTable.register(SignOutButtonCell.self, forCellReuseIdentifier: SignOutButtonCell.reuseID)
        settingsTable.register(AppearanceCell.self, forCellReuseIdentifier: AppearanceCell.reuseID)
        
        settingsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        settingsTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        settingsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        settingsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = Constants.navItemTitle
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? Constants.numberOfItemsInMainSection : Constants.numberOfItemsInSignOutSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = settingsTable.dequeueReusableCell(withIdentifier: AppearanceCell.reuseID, for: indexPath)
            guard let appearanceCell = cell as? AppearanceCell else { return cell }
            appearanceCell.configure ({[weak self] isOn in
                self?.appearanceSettings.changeTheme(isDark: isOn)
            }, isDark: appearanceSettings.getCurrentTheme())
            return appearanceCell
            
        case 1:
            let cell = settingsTable.dequeueReusableCell(withIdentifier: SignOutButtonCell.reuseID, for: indexPath)
            guard let signOutCell = cell as? SignOutButtonCell else { return cell }
            
            signOutCell.configure {[weak self] in
                self?.loginService?.signOut()
                self?.router?.loginViewController()
            }
            return signOutCell
            
        default:
            return UITableViewCell()
        }
    }
}
