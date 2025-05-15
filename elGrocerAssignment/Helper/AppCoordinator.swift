//
//  File.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit

class AppCoordinator {
    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let isLoggedIn = KeychainService.shared.getToken() != nil
        if isLoggedIn {
            showHome()
        } else {
            showLogin()
        }
    }

    func showLogin() {
        let vc = LoginViewController(viewModel: LoginViewModel())
        vc.onLoginSuccess = { [weak self] in self?.showHome() }
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }

    func showHome() {
        let homeVC = HomeViewController(viewModel: HomeViewModel())
        window.rootViewController = UINavigationController(rootViewController: homeVC)
        window.makeKeyAndVisible()
    }
}
