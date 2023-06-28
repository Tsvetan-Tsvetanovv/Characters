//
//  LaunchViewModel.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation

final class LaunchViewModel: ObservableObject {

    private weak var rootCoordinating: RootCoordinating?

    init(rootCoordinating: RootCoordinating?) {
        self.rootCoordinating = rootCoordinating
    }

    func requestAuthentication() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        let isAuthenticated = false

        await MainActor.run {
            if isAuthenticated {
                rootCoordinating?.didAuthenticate()
            } else {
                rootCoordinating?.authenticationFailed()
            }
        }
    }
}
