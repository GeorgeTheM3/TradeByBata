//
//  NetworkManager.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 18.03.2023.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    var loadingFlashSaleStatus: Bool = true
    var loadingLatestStatus: Bool = true
    
    func fetchData<T: Decodable>(urlString: String , model: T.Type, completion: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { data, _ , error  in
            if let data = data {
                do {
                    let result = try decoder.decode(model, from: data)
                    completion(result)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func loadImage(urlString: String, completion: @escaping (Data) -> Void) {
        let imageURL = URL(string: urlString)
        guard let urlPhoto = imageURL else { return }
        guard let imageData = try? Data(contentsOf: urlPhoto) else { return }
        completion(imageData)
    }
}
