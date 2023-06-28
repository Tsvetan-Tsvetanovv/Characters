//
//  HTTPClient.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

protocol HTTPClientProtocol {
    func data<T: Decodable>(for reques: URLRequest) async throws -> T
}

enum HTTPClientError: Error {
    case invalidResponse
    case mappingError
}

struct URLSessionHTTPClient: HTTPClientProtocol {

    func data<T: Decodable>(for reques: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: reques)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }

        guard (200..<300) ~= httpResponse.statusCode else {
            throw HTTPClientError.invalidResponse
        }

        guard let decodable = try? JSONDecoder().decode(T.self, from: data) else {
            throw HTTPClientError.mappingError
        }

        return decodable
    }
}
