//
//  SearchBarHeaderView.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import Foundation

import UIKit

class SearchBarHeader: UICollectionReusableView {
    private var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.placeholder = "What are you looking for?"
        searchTextField.layer.cornerRadius = 15
        searchTextField.clipsToBounds = true
        searchTextField.textAlignment = .center
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        return searchTextField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
