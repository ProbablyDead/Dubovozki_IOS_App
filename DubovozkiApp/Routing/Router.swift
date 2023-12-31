//
//  Router.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 03.12.2023.
//

import UIKit

// MARK: - Router main protocol
protocol RouterMainProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

// MARK: - Router protocol
protocol RouterProtocol: RouterMainProtocol {
    func loginViewController()
    func tabBarViewController()
    func additionalViewController(route: Route)
    func popToRoot()
}

// MARK: - Router class
class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func tabBarViewController() {
        if let navigationController = navigationController {
            guard let tabBarViewController = assemblyBuilder?.createTabBarModule(router: self) else { return }
            navigationController.viewControllers = [tabBarViewController]
        }
    }
    
    func loginViewController() {
        if let navigationController = navigationController {
            guard let loginViewController = assemblyBuilder?.createLoginModule(router: self) else { return }
            navigationController.pushViewController(loginViewController, animated: true)
        }
    }
    
    func additionalViewController(route: Route) {
        if let navigationController = navigationController {
            guard let additionalViewController = assemblyBuilder?.createAdditionalViewController(route: route) else { return }
            navigationController.present(additionalViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
