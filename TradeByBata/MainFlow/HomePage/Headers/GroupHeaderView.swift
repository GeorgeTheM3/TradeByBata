//
//  GroupHeaderView.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import UIKit

class GroupHeaderView: UICollectionReusableView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .helveticaBold15
        label.text = "Latest"
        return label
    }()

    private var shomMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("view all", for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(shomMoreButton)

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            shomMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            shomMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            shomMoreButton.heightAnchor.constraint(equalToConstant: frame.height/2)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GroupHeaderView: PassSettingsForHeaderProtocol {
    func headerSettings(_ title: String, _ image: UIImage?) {
        titleLabel.text = title
    }
}
