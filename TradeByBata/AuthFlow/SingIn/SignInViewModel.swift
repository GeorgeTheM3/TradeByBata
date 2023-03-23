//
//  SignInViewModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import Foundation

class SignInViewModel: NSObject {
    
    weak var coordinator: AuthCoordinator!
    
    private var firstName = String()
    private var lastName =  String()
    private var email = String()
    
    @objc dynamic var iRemmemberThisMan = false
    @objc dynamic var isEmailCorrect = false
    
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
    
    func checkEmail() {
        isEmailCorrect = LogicModel.shared.emailVerification(email: email)
    }
    
    func doYouKnowThisMan() {
        iRemmemberThisMan = UserDefaultsStorage.shared.checkUserInUserDefaults(firstName: firstName)
    }
    
    func saveThisUser() {
        let user = User(firstName: firstName, lastName: lastName, email: email, password: "", balance: 0, photo: nil)
        LocalStorage.shared.currentUser = user
        UserDefaultsStorage.shared.saveNewUser(user: user)
        print("user with email - \(user.email) saved")
    }
}
