//
//  BrandCell.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 22.03.2023.
//
import UIKit

class BrandCell: UICollectionViewCell {
    static let reuseId: String = "BrandCell"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFill
        imageView.frame = contentView.bounds
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BrandCell: PassProductToCellProtocol {
    func passProduct(_ product: Product) {
        if let image = UIImage(named: product.imageUrl) {
            photoImageView.image = image
        }
    }
}
