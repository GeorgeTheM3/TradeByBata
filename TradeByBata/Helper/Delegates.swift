//
//  Delegates.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import UIKit

protocol PassProductToCellProtocol: AnyObject {
    func passProduct(_ product: Product)
}

protocol PassSettingsForHeaderProtocol: AnyObject {
    func headerSettings(_ title: String, _ image: UIImage? )
}

protocol PassInfoToProfileCellProtocol: AnyObject {
    func passProduct(image: UIImage?, title: String, hideRightImage: Bool, hideMoneyLabel: Bool, money: Int?)
}
