//
//  HomePageViewModelProtocol.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

protocol HomePageViewModelProtocol {
    var loadingStatus: Bool { get set }
    var latestProducts: [Product] { get set }
    var flashSaleProducts: [Product] { get set }
}
