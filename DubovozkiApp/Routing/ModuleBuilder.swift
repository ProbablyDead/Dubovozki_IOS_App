//
//  ModuleBuilder.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 02.12.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createTabBarModule(router: RouterProtocol) -> UIViewController
    func createScheduleModule() -> UIViewController
    func createMapModule() -> UIViewController
    func createSettingsModule(loginService: LoginServiceProtocol, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    private var loginService: LoginServiceProtocol
    private var networkDataService: NetworkDataServiceProtocol
    
    init(loginService: LoginServiceProtocol, networkDataService: NetworkDataServiceProtocol) {
        self.loginService = loginService
        self.networkDataService = networkDataService
    }
    
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        view.router = router
        view.loginService = self.loginService
        return view
    }
    
    func createTabBarModule(router: RouterProtocol) -> UIViewController {
        TabBarViewController(mapViewController: createMapModule(), scheduleViewController: createScheduleModule(), settingsViewController: createSettingsModule(loginService: self.loginService, router: router), router: router)
    }
    
    internal func createMapModule() -> UIViewController {
        StationsViewController()
    }
    
    internal func createScheduleModule() -> UIViewController {
        let view = PagedScheduleViewController()
        let model = ScheduleModel(networkDataService: self.networkDataService)
        
        let presenter = ScheduleViewPresenter(view: view, model: model)
        view.presenter = presenter
        
        return view
    }
    
    internal func createSettingsModule(loginService: LoginServiceProtocol, router: RouterProtocol) -> UIViewController {
        let settingsViewController = SettingsViewController()
        settingsViewController.loginService = self.loginService
        settingsViewController.router = router
        return settingsViewController
    }
}
