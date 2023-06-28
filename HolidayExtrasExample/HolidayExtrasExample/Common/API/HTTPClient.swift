//
//  HTTPClient.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

protocol HTTPClientProtocol {
    func data(for reques: URLRequest) async throws -> Data
}

enum HTTPClientError: Error {
    case invalidResponse
}

struct URLSessionHTTPClient: HTTPClientProtocol {

    func data(for reques: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: reques)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }

        guard (200..<300) ~= httpResponse.statusCode else {
            throw HTTPClientError.invalidResponse
        }

        return data
    }
}
