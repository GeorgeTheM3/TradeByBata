//
//  ProfilePageViewModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 21.03.2023.
//


import Foundation

class ProfilePageViewModel {
    
}

extension ProfilePageViewModel: ProfilePageViewModelProtocol {
    func getUserFullName() -> String {
        guard let user = LocalStorage.shared.currentUser else { return "" }
        let userName = user.firstName + " " + user.lastName
        return userName
    }
    
    func getUserMoney() -> Int {
        let userBalance = LocalStorage.shared.currentUser.balance
        return userBalance
    }
    
    func getUserPhoto() -> Data? {
        guard let userPhoto = LocalStorage.shared.currentUser.photo else { return nil }
        return userPhoto
    }
    
}
