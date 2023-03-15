//
//  SignInViewModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import Foundation

class SignInViewModel {
    private var firstName = String()
    private var lastName =  String()
    private var email = String()
    
    deinit {
        print("deinit model")
    }
    
}

extension SignInViewModel: SignInViewModelProtocol {
    func enterFirstName(_ firstname: String) {
        self.firstName = firstname
    }
    
    func enterLastName(_ lastname: String) {
        self.lastName = lastname
    }
    
    func enterEmail(_ email: String) {
        self.email = email
    }
}
