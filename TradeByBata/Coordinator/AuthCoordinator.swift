//
//  AuthCoordinator.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//
import UIKit

class AuthCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let singInScreen = SingInView(viewModel: SignInViewModel())
        navigationController.pushViewController(singInScreen, animated: false)
    }
}
