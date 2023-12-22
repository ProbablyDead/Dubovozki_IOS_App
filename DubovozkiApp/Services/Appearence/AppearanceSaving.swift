//
//  AppearenceSaving.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 22.12.2023.
//

import Foundation
import UIKit

class AppearanceSaving {
    public static var window: UIWindow?
    
    public func changeTheme(isDark: Bool) {
        Self.window?.overrideUserInterfaceStyle = isDark ? .dark : .light
    }
}
