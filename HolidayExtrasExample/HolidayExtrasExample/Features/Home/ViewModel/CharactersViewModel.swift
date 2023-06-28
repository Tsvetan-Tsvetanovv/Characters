//
//  CharactersViewModel.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

final class CharactersViewModel: ObservableObject {
    
    @Published private(set) var characters: [Character] = []

    private let repository: CharacterRepository
    private weak var homeCoordinating: HomeCoordinating?

    init(
        homeCoordinating: HomeCoordinating,
        repository: CharacterRepository
    ) {
        self.homeCoordinating = homeCoordinating
        self.repository = repository
    }

    func select(_ character: Character) {
        homeCoordinating?.showCharacter(character)
    }

    func getCharacters() async {
        guard let characters = try? await repository.getCharacters() else {
            return
        }

        await MainActor.run { [weak self] in
            self?.characters = characters
        }
    }
}
