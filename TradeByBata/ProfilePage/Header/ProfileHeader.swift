//
//  ProfileHeader.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 21.03.2023.
//

import UIKit

class ProfileHeader: UITableViewHeaderFooterView {
    static let reuseId: String = "ProfileHeader"
    
    private let heightWindow = UIScreen.main.bounds.height
    private let widthWindow = UIScreen.main.bounds.width
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let height = heightWindow * 0.08
        imageView.layer.cornerRadius = height/2
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: widthWindow/2 - (height/2), y: 3, width: height, height: height)
        return imageView
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Chage photo", for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .helveticaBold15
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: Int(photoImageView.bounds.height * 1.4), width: Int(widthWindow), height: Int(heightWindow * 0.04))
        return label
    }()
    
    private lazy var upLoadItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload item", for: .normal)
        button.backgroundColor = .buttonColor
        button.tintColor = .white
       
        let width = widthWindow * 0.85
        let height = heightWindow * 0.04
        let y = photoImageView.bounds.height + nameLabel.bounds.height * 2
        button.layer.cornerRadius = height/4
        button.clipsToBounds = true
        button.frame = CGRect(x: widthWindow/2 - (width/2), y: y , width: width, height: height)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(photoImageView)
        addSubview(changePhotoButton)
        addSubview(nameLabel)
        addSubview(upLoadItemButton)
        setConstraintsSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraintsSubviews() {
        NSLayoutConstraint.activate([
            changePhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            changePhotoButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
            changePhotoButton.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
}

extension ProfileHeader: PassSettingsForHeaderProtocol {
    func headerSettings(_ title: String, _ image: UIImage?) {
        photoImageView.image = image
        nameLabel.text = title
    }
}
