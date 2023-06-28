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

class CharacterRepository: CharacterRepositoryProtocol {
    
    private let rickAndMortyAPI: RickAndMortyAPIProtocol

    init(rickAndMortyAPI: RickAndMortyAPIProtocol) {
        self.rickAndMortyAPI = rickAndMortyAPI
    }

    func getCharacters() async throws -> [Character] {
        try await rickAndMortyAPI.getCharacters()
    }
}
