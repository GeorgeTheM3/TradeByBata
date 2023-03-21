//
//  UserModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 20.03.2023.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let balance: Int
    let photo: Data?
}
