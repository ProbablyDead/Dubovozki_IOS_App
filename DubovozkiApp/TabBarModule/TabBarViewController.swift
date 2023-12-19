//
//  TabBarViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 05.12.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    var mapViewController: UIViewController!
    var scheduleViewController: UIViewController!
    var settingsViewController: UIViewController!
    var router: RouterProtocol?
    
    init(mapViewController: UIViewController, scheduleViewController: UIViewController, settingsViewController: UIViewController, router: RouterProtocol) {
        self.mapViewController = mapViewController
        self.scheduleViewController = scheduleViewController
        self.settingsViewController = settingsViewController
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private enum TabBarItem: Int {
        case map
        case schedule
        case settings
        
        var title: String {
            switch self {
            case .map:
                "Stations"
            case .schedule:
                "Schedule"
            case .settings:
                "Settings"
            }
        }
        
        var iconName: String {
            switch self {
            case .map:
                "map.fill"
            case .schedule:
                "calendar"
            case .settings:
                "gear"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedIndex = 1
    }
    
    private func configureTabBar() {
        tabBar.backgroundColor = .secondarySystemBackground
        tabBar.tintColor = .app
        
        let dataSource: [TabBarItem] = [.map, .schedule, .settings]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .map:
                mapViewController
            case .schedule:
                scheduleViewController
            case .settings:
                settingsViewController
            }
            
        }
        
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
        }
        
        selectedViewController = viewControllers?[1]
    }
}
