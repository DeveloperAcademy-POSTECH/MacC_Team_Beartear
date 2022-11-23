//
//  UserDefaults.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let userFirstUsedAppDate = "userFirstUsedAppDate"
    }
    
    var userFirstUsedAppDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.userFirstUsedAppDate) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userFirstUsedAppDate)
        }
    }
}
