//
//  AppearenceSaving.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 22.12.2023.
//

import Foundation
import UIKit

class AppearanceSaving {
    public static let shared = AppearanceSaving()
    
    private enum Constants {
        static let themeKey: String = "IsDark"
    }
    
    public static var window: UIWindow?
    
    public func changeTheme(isDark: Bool) {
        Self.window?.overrideUserInterfaceStyle = isDark ? .dark : .light
        UserDefaults.standard.set(isDark, forKey: Constants.themeKey)
    }
    
    public func getCurrentTheme () -> Bool {
        UserDefaults.standard.bool(forKey: Constants.themeKey)
    }
    
    public func applyDefaults() {
        changeTheme(isDark: getCurrentTheme())
    }
}
