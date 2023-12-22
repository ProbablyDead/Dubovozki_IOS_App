//
//  Extension+String.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 22.12.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
