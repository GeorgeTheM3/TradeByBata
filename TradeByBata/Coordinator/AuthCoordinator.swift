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
        let viewModel = SignInViewModel()
        viewModel.coordinator = self
        let singInScreen = SingInView(viewModel: viewModel)
        navigationController.pushViewController(singInScreen, animated: false)
    }
    
    func goToLoginScreen() {
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        let loginScreen = LoginView(viewModel: viewModel)
        navigationController.pushViewController(loginScreen, animated: false)
    }
}
