//
//  MockAuth.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 18/12/2025.
//

import Foundation

struct MockAuth {
    
    enum Key: String {
        case loggedUserIDs
    }
    
    private var userDefaults = UserDefaults.standard

    static func saveloggedEmails(_ history: [String]) {
        UserDefaults.standard.set(history, forKey: Key.loggedUserIDs.rawValue)
    }

    static func getLoggedEmails() -> [String] {
        return UserDefaults.standard.stringArray(forKey: Key.loggedUserIDs.rawValue) ?? []
    }
    
    static func saveEmail(_ item: String) {
        var current = getLoggedEmails()
        if !current.contains(item) {
            current.append(item)
            saveloggedEmails(current)
        }
    }
}
