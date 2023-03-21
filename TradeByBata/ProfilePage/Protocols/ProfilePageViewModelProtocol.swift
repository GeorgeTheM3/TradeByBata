//
//  ProfilePageViewModelProtocol.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 21.03.2023.
//

import Foundation

protocol ProfilePageViewModelProtocol {
    func getUserFullName() -> String
    
    func getUserMoney() -> Int
    
    func getUserPhoto() -> Data?
}
