//
//  FlashSaleCell.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import UIKit

class FlashSaleCell: UICollectionViewCell {
    static let reuseId: String = "FlashSaleCell"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFill
        imageView.frame = contentView.bounds
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(titleProductLabel)
        stackView.addArrangedSubview(priceProductLabel)
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.frame = CGRect(x: 5, y: bounds.height/1.35, width: bounds.width/2, height: bounds.width/4)
        return stackView
    }()
    
    private lazy var categoryProductLabel: UILabel = {
        let label = UILabel()
        label.text = "Kids"
        label.font = .helvetica9
        label.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        label.frame = CGRect(x: 5, y: bounds.height/1.55, width: 40, height: 15)
        label.textAlignment = .center
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.text = "30% off"
        label.font = .helveticaBold8
        label.backgroundColor = .red
        label.textColor = .white
        label.frame = CGRect(x: bounds.width - 55, y: 10, width: 45, height: bounds.height * 0.08)
        label.textAlignment = .center
        label.layer.cornerRadius = (bounds.height * 0.08)/2
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
    
    private(set) lazy var addToBasketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        let width = (bounds.width/5)
        button.layer.cornerRadius = width/2
        button.clipsToBounds = true
        button.frame = CGRect(x: bounds.width - width * 1.3, y: bounds.height - width * 1.3, width: width, height: width)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        let width = (bounds.width/6)
        button.layer.cornerRadius = width/2
        button.clipsToBounds = true
        button.frame = CGRect(x: bounds.width - width * 2.7, y: bounds.height - width * 1.4, width: width, height: width)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(discountLabel)
        contentView.addSubview(categoryProductLabel)
        contentView.addSubview(addToBasketButton)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlashSaleCell: PassProductToCellProtocol {
    func passProduct(_ product: Product) {
        if let imageData = product.imageData {
            photoImageView.image = UIImage(data: imageData)
        }
        categoryProductLabel.text = product.category
        titleProductLabel.text = product.name
        priceProductLabel.text = ("$\(product.price)")
    }
}
