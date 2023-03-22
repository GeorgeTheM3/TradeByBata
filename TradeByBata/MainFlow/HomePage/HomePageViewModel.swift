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
    
    override init() {
        super.init()
        downloadStartInfo()
    }
    
    func checkStatus() {
        if !NetworkManager.shared.loadingFlashSaleStatus && !NetworkManager.shared.loadingLatestStatus {
            loadingStatus = false
        }
    }
    
    func getUserPhoto() -> Data? {
        guard let userPhoto = LocalStorage.shared.currentUser.photo else { return nil }
        return userPhoto
    }
    
    func downloadStartInfo() {
        loadingStatus = true
        NetworkManager.shared.fetchData(urlString: "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac", model: FlashSale.self) { flashSales in
            NetworkManager.shared.loadingFlashSaleStatus = true
            for item in flashSales.flashSale {
                let url = self.changPhotoUrl(name: item.name)
                var product = Product(category: item.category, name: item.name, price: item.price, discount: item.discount, imageUrl: url, imageData: nil)
                NetworkManager.shared.loadImage(urlString: url) { imageData in
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
                let url = self.changPhotoUrl(name: item.name)
                var product = Product(category: item.category, name: item.name, price: item.price, discount: item.discount, imageUrl: url, imageData: nil)
                NetworkManager.shared.loadImage(urlString: url) { imageData in
                    product.imageData = imageData
                    self.latestProducts.append(product)
                    print("\(product.name) is loaded")
                }
            }
            NetworkManager.shared.loadingLatestStatus = false
            self.checkStatus()
        }
    }
    
    private func changPhotoUrl(name: String) -> String{
        switch name {
        case "Samsung S10":
            return "https://i.ebayimg.com/00/s/OTAwWDkwMA==/z/RGAAAOSwgsRivLQ8/$_57.JPG?set_id=8800005007"
        case "Sony Playstation 5":
        return "https://avatars.mds.yandex.net/get-marketpic/7074617/pic99bb77dd6fe034aad2d493788d83f1cf/orig"
        case "Xbox ONE":
        return "https://kotofoto.ru/product_img/2452/191873/191873_igrovaya_konsol_microsoft_xbox_one_s_1tb_white_3_mesyatsa_game_pass_3_mesyatsa_live_goldm.jpg?v=1549267191"
        case "BMW X6M":
        return "https://mobimg.b-cdn.net/v3/fetch/b2/b20fdf022f9587d775298e5c5df3a96f.jpeg"
        case "New Balance Sneakers":
            return "https://cdn.dsmcdn.com/mnresize/1200/1800/ty25/product/media/images/20201120/22/29283354/108832210/1/1_org_zoom.jpg"
        case "Reebok Classic":
            return "https://cdn1.ozone.ru/s3/multimedia-d/6344448481.jpg"
        default:
            return ""
        }
    }
}
