//
//  LoginViewModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import Foundation

class LoginViewModel {
    private var firstName = String()
    private var password =  String()
}

extension LoginViewModel: LoginViewModelProtocol {
    func enterFirstName(_ firstname: String) {
        self.firstName = firstname
    }
    
    func enterPassword(_ password: String) {
        self.password = password
    }
}
