//
//  ProductModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 18.03.2023.
//

import Foundation

struct Product: Decodable, Hashable {
    let identifier: UUID = UUID()
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    let category: String
    let name: String
    let price: Double
    var discount: Int?
    let imageUrl: String
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case category
        case name
        case price
        case discount
        case imageUrl = "image_url"
        case imageData
    }
}
