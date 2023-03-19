//
//  HomePageViewModel.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import Foundation

class HomePageViewModel: NSObject, HomePageViewModelProtocol {
    
    @objc dynamic var loadingStatus = false
    
    var latestProducts: [Product] = []
    var flashSaleProducts: [Product] = []
    
    func checkStatus() {
        if !NetworkManager.shared.loadingFlashSaleStatus && !NetworkManager.shared.loadingLatestStatus {
            loadingStatus = false
        }
    }
    
    override init() {
        super.init()
        downloadStartInfo()
    }
    
    func downloadStartInfo() {
        loadingStatus = true
        NetworkManager.shared.fetchData(urlString: "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac", model: FlashSale.self) { flashSales in
            NetworkManager.shared.loadingFlashSaleStatus = true
            for item in flashSales.flashSale {
                var product = Product(category: item.category, name: item.name, price: item.price, discount: item.discount, imageUrl: item.imageUrl, imageData: nil)
                NetworkManager.shared.loadImage(urlString: item.imageUrl) { imageData in
                    product.imageData = imageData
                    self.flashSaleProducts.append(product)
                    print("\(product.name) is loaded")
                }
            }
            NetworkManager.shared.loadingFlashSaleStatus = false
            self.checkStatus()
        }
        
        NetworkManager.shared.fetchData(urlString: "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7", model: Latest.self) { latests in
            NetworkManager.shared.loadingLatestStatus = true
            for item in latests.latest {
                var product = Product(category: item.category, name: item.name, price: item.price, discount: item.discount, imageUrl: item.imageUrl, imageData: nil)
                NetworkManager.shared.loadImage(urlString: item.imageUrl) { imageData in
                    product.imageData = imageData
                    self.latestProducts.append(product)
                    print("\(product.name) is loaded")
                }
            }
            NetworkManager.shared.loadingLatestStatus = false
            self.checkStatus()
        }
    }
}
