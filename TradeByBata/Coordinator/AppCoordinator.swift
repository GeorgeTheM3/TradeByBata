//
//  AppCoordinator.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    var isLogged: Bool = false
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if isLogged {
            let singInScreen = CategoriesCollectionView()
            navigationController.pushViewController(singInScreen, animated: false)
        } else {
            let authCoordinator = AuthCoordinator(navigationController: navigationController)
            childCoordinators.append(authCoordinator)
            authCoordinator.start()
        }
    }
}
