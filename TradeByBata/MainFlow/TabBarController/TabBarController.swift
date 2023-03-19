//
//  TabBarController.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import UIKit

class TabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = configureTabBar()
        customizationTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTabBar() -> [UIViewController]{
        var controllers: [UIViewController] = []
        
        let homeViewController = HomePageCollectionView(viewModel: HomePageViewModel()) // add controllerç
        homeViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        controllers.append(homeNavigationController)
        
        let chatsViewController = UIViewController() // add controller
        chatsViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        let chatsNavigationController = UINavigationController(rootViewController: chatsViewController)
        controllers.append(chatsNavigationController)
        
        let cfViewController = UIViewController() // add controller
        cfViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "basket"), selectedImage: UIImage(systemName: "basket.fill"))
        let cNavigationController = UINavigationController(rootViewController: cfViewController)
        controllers.append(cNavigationController)
        
        let chaViewController = UIViewController() // add controller
        chaViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "text.bubble"), selectedImage: UIImage(systemName: "text.bubble.fill"))
        let chaNavigationController = UINavigationController(rootViewController: chaViewController)
        controllers.append(chaNavigationController)
        
        let profileViewController = ProfilePageView(viewModel: ProfilePageViewModel()) // add controller
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        controllers.append(profileNavigationController)
        
        return controllers
    }
    
    private func customizationTabBar() {
        let positionX: CGFloat = 0
        let positionY: CGFloat = 15
        let width = tabBar.bounds.width
        let heigh = tabBar.bounds.height * 2

        let corners = UIRectCorner([.topLeft, .topRight])
        let cgRect = CGRect(x: positionX, y: tabBar.bounds.minY - positionY, width: width, height: heigh)
        let beziePath = UIBezierPath(roundedRect: cgRect, byRoundingCorners: corners, cornerRadii: CGSize(width: 30, height: 30))

        let roundLayer = CAShapeLayer()
        roundLayer.path = beziePath.cgPath
        roundLayer.fillColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)

        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemBackgroundColor
    }
}

