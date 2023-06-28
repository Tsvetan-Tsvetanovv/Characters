//
//  MainCoordinator.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import UIKit
import SwiftUI

protocol HomeCoordinating: AnyObject {
    func showCharacter(_ character: Character)
}

final class MainCoordinator {

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
        let client = URLSessionHTTPClient()
        let api = RickAndMortyAPI(client: client)
        let repository = CharacterRepository(rickAndMortyAPI: api)
        let viewModel = CharactersViewModel(homeCoordinating: self, repository: repository)
        let homeScreen = CharactersScreen(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: homeScreen)
        navigationController.setViewControllers([hostingController], animated: true)
    }
}

extension MainCoordinator: HomeCoordinating {

    func showCharacter(_ character: Character) {
        let screen = CharacterDetailsScreen(character: character)
        let hostingController = UIHostingController(rootView: screen)

        navigationController.pushViewController(hostingController, animated: true)
    }
}
