//
//  CoordinatorProtocol.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    func start()
}
