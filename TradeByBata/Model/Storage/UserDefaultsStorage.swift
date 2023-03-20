//
//  UserDefaultsStorage.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 20.03.2023.
//

import Foundation

class UserDefaultsStorage {
    static let shared = UserDefaultsStorage()
    
    private let userDefaults =  UserDefaults.standard
    
    func saveNewUser(user: User) {
        let encodeUser = try? JSONEncoder().encode(user)
        userDefaults.set(encodeUser, forKey: user.firstName)
    }
    
    func checkUserInUserDefaults(firstName: String) -> Bool {
        guard let userData = userDefaults.data(forKey: firstName) else { return false }
        let user = try? JSONDecoder().decode(User.self, from: userData)
        if let user = user {
            print("Find user -> \(user)")
            return true
        } else {
            return false
        }
    }
}
