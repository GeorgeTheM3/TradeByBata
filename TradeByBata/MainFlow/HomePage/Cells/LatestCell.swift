//
//  LatestCell.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import UIKit

class LatestCell: UICollectionViewCell {
    static let reuseId: String = "LatestCell"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFit
        imageView.frame = contentView.bounds
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(titleProductLabel)
        stackView.addArrangedSubview(priceProductLabel)
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.frame = CGRect(x: 5, y: bounds.height/1.5, width: bounds.width/1.3, height: bounds.width/3)
        return stackView
    }()
    
    private lazy var categoryProductLabel: UILabel = {
        let label = UILabel()
        label.text = "Kids"
        label.font = .helvetica9
        label.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        label.frame = CGRect(x: 5, y: bounds.height/1.8, width: 40, height: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var titleProductLabel: UILabel = {
        let label = UILabel()
        label.text = "New Balance"
        label.font = .helvetica11
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceProductLabel: UILabel = {
        let label = UILabel()
        label.text = "$200,00"
        label.font = .helvetica9
        return label
    }()
    
    private lazy var addToBasketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        let width = (bounds.width/6)
        button.layer.cornerRadius = width/2
        button.clipsToBounds = true
        button.frame = CGRect(x: bounds.width - width * 1.3, y: bounds.height - width * 1.3, width: width, height: width)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(categoryProductLabel)
        contentView.addSubview(addToBasketButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LatestCell: PassProductToCellProtocol {
    func passProduct(_ product: Product) {
        if let imageData = product.imageData {
            photoImageView.image = UIImage(data: imageData)
        }
        categoryProductLabel.text = product.category
        titleProductLabel.text = product.name
        priceProductLabel.text = ("$\(product.price)")
    }
}
