//
//  LogicModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 20.03.2023.
//

import Foundation

class LogicModel {
    static let shared = LogicModel()
    
    func emailVerification(email: String) -> Bool {
        var result = false
        let arrayDomens = ["@mail.ru" , "@yandex.ru", "@gmail.com"]
        for domen in arrayDomens {
            if email.hasSuffix(domen) {
                print("\(email) has suffix \(domen)")
                result = true
            } else {
                print("\(email) dont has suffix \(domen)")
            }
        }
        return result
    }
}

