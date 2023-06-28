//
//  AuthCoordinator.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import UIKit
import SwiftUI

protocol SignUpCoordinating: AnyObject {
    func signUp()
    func requestSignIn()
}

protocol SignInCoordinating: AnyObject {
    func signIn()
    func requestSignUp()
}

final class AuthCoordinator {

    private let navigationController: UINavigationController

    private weak var parent: RootCoordinator?

    init(
        navigationController: UINavigationController,
        parent: RootCoordinator
    ) {
        self.navigationController = navigationController
        self.parent = parent
    }

    func start() {
        showSignIn()
    }

    private func showSignIn() {
        let signInViewModel = SignInViewModel(signInCoordinating: self)
        let signInScreen = SignInScreen(viewModel: signInViewModel)
        let hostingController = UIHostingController(rootView: signInScreen)
        navigationController.setViewControllers([hostingController], animated: true)
        hostingController.navigationController?.navigationBar.prefersLargeTitles = true

    }

    private func showSignUp() {
        let signUpViewModel = SignUpViewModel(signUpCoordinating: self)
        let signUpScreen = SignUpScreen(viewModel: signUpViewModel)
        let hostingController = UIHostingController(rootView: signUpScreen)
        navigationController.setViewControllers([hostingController], animated: true)
        hostingController.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension AuthCoordinator: SignInCoordinating {

    func signIn() {
        parent?.didAuthenticate()
    }

    func requestSignUp() {
        showSignUp()
    }
}

extension AuthCoordinator: SignUpCoordinating {
    
    func signUp() {
        parent?.didAuthenticate()
    }

    func requestSignIn() {
        showSignIn()
    }
}
