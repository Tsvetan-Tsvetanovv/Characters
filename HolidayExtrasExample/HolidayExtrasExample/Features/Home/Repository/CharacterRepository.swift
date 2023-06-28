//
//  CharacterRepository.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacters() async throws -> [Character]
}

enum CharacterRepositoryError: Error {
    case invalidURL
    case mappingError
}

class CharacterRepository: CharacterRepositoryProtocol {
    private static let url = "https://rickandmortyapi.com/api/character"

    private let client: HTTPClientProtocol

    init(client: HTTPClientProtocol) {
        self.client = client
    }

    func getCharacters() async throws -> [Character] {
        guard let url = URL(string: CharacterRepository.url) else {
            throw CharacterRepositoryError.invalidURL
        }

        let request = URLRequest(url: url)
        let data = try await client.data(for: request)

        guard let characterResponse = try? JSONDecoder().decode(CharacterResponse.self, from: data) else {
            throw CharacterRepositoryError.mappingError
        }

        return characterResponse.results
    }
}
