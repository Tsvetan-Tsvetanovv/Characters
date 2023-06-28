//
//  LaunchScreen.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI

struct LaunchScreen: View {

    @ObservedObject private var viewModel: LaunchViewModel

    init(viewModel: LaunchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await viewModel.requestAuthentication()
        }
    }
}
