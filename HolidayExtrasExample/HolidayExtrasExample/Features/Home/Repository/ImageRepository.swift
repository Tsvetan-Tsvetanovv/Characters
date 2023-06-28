//
//  ImageRepository.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

protocol ImageRepositoryProtocol {
    func imageData(from url: String) async throws -> Data
}

enum ImageRepositoryError: Error {
    case invalidURL
}

struct ImageRepository: ImageRepositoryProtocol {

    private let client: HTTPClientProtocol

    init(client: HTTPClientProtocol) {
        self.client = client
    }

    func imageData(from url: String) async throws -> Data {

        guard let url = URL(string: url) else {
            throw ImageRepositoryError.invalidURL
        }

        let request = URLRequest(url: url)

        return try await client.data(for: request)
    }
}
