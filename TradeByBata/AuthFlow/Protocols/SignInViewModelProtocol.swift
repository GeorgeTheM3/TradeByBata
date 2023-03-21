//
//  SignInViewModelProtocol.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

protocol SignInViewModelProtocol {
    func enterFirstName(_ firstname: String)
    func enterLastName(_ lastname: String)
    func enterEmail(_ email: String)
    func doYouKnowThisMan()
    func checkEmail()
    func saveThisUser()
}
