//
//  UIViewController + Extensions.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 18.03.2023.
//

import UIKit

extension UIViewController {
    // for setup custom navigation bar
    func createCustomNavigationBar(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .black
    }
    
    // for adding bar button with systemImage
    func createBarButton(systemNameImage: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: systemNameImage), for: .normal)
        button.imageView?.frame = view.bounds
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.addTarget(self, action: selector, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    // for adding bar button with any UIImage
    func createCustomBarButton(imageNamed: UIImage, selector: Selector) -> UIBarButtonItem {
        let imageView = UIImageView()
        imageView.image = imageNamed
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        let barButton = UIBarButtonItem(customView: imageView)
        return barButton
    }
}
