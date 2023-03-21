//
//  ProfileCustomCell.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 21.03.2023.
//

import UIKit

class ProfileCustomCell: UITableViewCell {
    static let reuseId: String = "ProfileCustomCell"
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFit
        let height = Int(contentView.bounds.height)
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .black
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 30, y: height/2 - 7, width: 40, height: 40)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trade store"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.text = "$100"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImageView)
        contentView.addSubview(moneyLabel)
        setConstraintsSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraintsSubviews() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            
            rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31),
            rightImageView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            rightImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height/2),
            rightImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.height/2),
            
            moneyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -41),
            moneyLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
        ])
    }
}

extension ProfileCustomCell: PassInfoToProfileCellProtocol {
    func passProduct(image: UIImage?, title: String, hideRightImage: Bool, hideMoneyLabel: Bool, money: Int?) {
        titleLabel.text = title
        moneyLabel.isHidden = hideMoneyLabel
        rightImageView.isHidden = hideRightImage
        if let image = image {
            logoImageView.image = image
        }
        if let money = money {
            moneyLabel.text = "$\(money)"
        }
    }
    
}
