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
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let loginService = LoginService()
        view.router = router
        view.loginService = loginService
        return view
    }
    
    func createTabBarModule(router: RouterProtocol) -> UIViewController {
        TabBarViewController(mapViewController: createMapModule(), scheduleViewController: createScheduleModule(), settingsViewController: createSettingsModule(loginService: LoginService(), router: router), router: router)
    }
    
    internal func createMapModule() -> UIViewController {
        MapViewController()
    }
    
    internal func createScheduleModule() -> UIViewController {
        let view = PagedScheduleViewController()
        let model = ScheduleModel()
        
        let presenter = ScheduleViewPresenter(view: view, model: model)
        view.presenter = presenter
        
        return view
    }
    
    internal func createSettingsModule(loginService: LoginServiceProtocol, router: RouterProtocol) -> UIViewController {
        let settingsViewController = SettingsViewController()
        settingsViewController.loginService = loginService
        settingsViewController.router = router
        return settingsViewController
    }
}
