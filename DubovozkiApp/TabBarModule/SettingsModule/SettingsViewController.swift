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
    }
    
    var loginService: LoginServiceProtocol?
    var router: RouterProtocol?
    
    private lazy var signOutButton: UIButton = {
        let controller = UIButton()
        controller.setTitle(Constants.signOutButtonTitle, for: .normal)
        controller.backgroundColor = .black
        controller.tintColor = .white
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return controller
    }()
    
    @objc
    private func signOutButtonPressed(_ sender: UIButton) {
        loginService?.signOut()
        router?.loginViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .accent
        view.addSubview(signOutButton)
        
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = Constants.navItemTitle
    }
}
