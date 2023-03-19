//
//  CategoriesCell.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    static let reuseId: String = "CategoriesCell"
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.backgroundColor = .systemGray4
        button.tintColor = .black
        let width = (bounds.width/1.3)
        button.layer.cornerRadius = width/2
        button.clipsToBounds = true
        button.frame = CGRect(x: (bounds.width - width)/2, y: 0, width: width, height: width)
        return button
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .helvetica9
        label.textAlignment = .center
        let size = categoryButton.bounds.height
        label.frame = CGRect(x: 0, y: size + 5, width: bounds.width, height: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryButton)
        contentView.addSubview(categoryTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoriesCell: PassProductToCellProtocol {
    func passProduct(_ product: Product) {
        categoryTitleLabel.text = product.category
        categoryButton.setImage(UIImage(systemName: product.imageUrl), for: .normal)
    }
    
}
