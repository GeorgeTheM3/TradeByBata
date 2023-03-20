//
//  LocalStorage.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 20.03.2023.
//

import Foundation

class LocalStorage {
    static let shared = LocalStorage()
    var latestProducts: [Product] = []
    var flashSaleProducts: [Product] = []
    
    func saveLatestProduct(_ product: Product) {
        latestProducts.append(product)
    }
    
    func flashSaleProduct(_ product: Product) {
        flashSaleProducts.append(product)
    }
}
