//
//  RootCoordinator.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import UIKit
import SwiftUI

protocol RootCoordinating: AnyObject {
    func didAuthenticate()
    func authenticationFailed()
}

final class RootCoordinator {

    private let navigationController: UINavigationController

    private var authCoordinator: AuthCoordinator?
    private var mainCoordinator: MainCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = LaunchViewModel(rootCoordinating: self)
        let screen = LaunchScreen(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: screen)
        navigationController.setViewControllers([hostingController], animated: true)
    }
}

extension RootCoordinator: RootCoordinating {

    func didAuthenticate() {
        let mainCoordinator = MainCoordinator(
            navigationController: navigationController,
            parent: self
        )

        self.mainCoordinator = mainCoordinator
        mainCoordinator.start()
    }

    func authenticationFailed() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            parent: self
        )

        self.authCoordinator = authCoordinator
        authCoordinator.start()
    }
}
