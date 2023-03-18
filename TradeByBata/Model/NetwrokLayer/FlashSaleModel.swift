//
//  FlashSaleModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 18.03.2023.
//

import Foundation

struct FlashSale: Decodable {
    let flashSale: [Product]
    
    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}
