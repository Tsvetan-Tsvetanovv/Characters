//
//  RickAndMortyAPI.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

protocol RickAndMortyAPIProtocol {
    func getCharacters() async throws -> [Character]
}

enum RickAndMortyAPIError: Error {
    case invalidURL
}

struct RickAndMortyAPI: RickAndMortyAPIProtocol {

    private let client: HTTPClientProtocol

    init(client: HTTPClientProtocol) {
        self.client = client
    }
    
    func getCharacters() async throws -> [Character] {

        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            throw RickAndMortyAPIError.invalidURL
        }

        let request = URLRequest(url: url)
        let response: CharacterResponse = try await client.data(for: request)

        return response.results
    }
}
