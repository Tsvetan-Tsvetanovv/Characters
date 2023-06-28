//
//  CharactersViewModel.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

final class CharactersViewModel: ObservableObject {
    
    @Published private(set) var characterItems: [CharacterViewItem] = []
    private var characters: [Character] = []

    private let repository: CharacterRepositoryProtocol
    private weak var homeCoordinating: HomeCoordinating?

    init(
        homeCoordinating: HomeCoordinating,
        repository: CharacterRepositoryProtocol
    ) {
        self.homeCoordinating = homeCoordinating
        self.repository = repository
    }

    func selectCharacter(_ character: CharacterViewItem) {
        guard let character = characters.first(where: { $0.id == character.id }) else { return }
        homeCoordinating?.showCharacter(character)
    }

    func getCharacters() async {
        guard let characters = try? await repository.getCharacters() else {
            return
        }

        await MainActor.run { [weak self] in
            self?.characters = characters
            self?.characterItems = self?.characterViewItems(from: characters) ?? []
        }
    }

    func characterViewItems(from characters: [Character]) -> [CharacterViewItem] {
        characters.map {
            CharacterViewItem(
                id: $0.id,
                name: $0.name,
                imageUrl: URL(string: $0.image)
            )
        }
    }
}
