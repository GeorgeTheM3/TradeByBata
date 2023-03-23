//
//  LoginViewModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import Foundation

class LoginViewModel: NSObject {
    
    weak var coordinator: AuthCoordinator!
    
    private var firstName = String()
    private var password =  String()
    
    @objc dynamic var iRemmemberThisMan = false
}

extension LoginViewModel: LoginViewModelProtocol {
    func doYouKnowThisMan() {
        iRemmemberThisMan = UserDefaultsStorage.shared.checkUserInUserDefaults(firstName: firstName)
        let user = UserDefaultsStorage.shared.getUserFromUserDefaults(firstName: firstName)
        LocalStorage.shared.currentUser = user
    }
    
    func enterFirstName(_ firstname: String) {
        self.firstName = firstname
    }
    
    func enterPassword(_ password: String) {
        self.password = password
    }
}
