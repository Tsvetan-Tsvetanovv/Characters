//
//  AvatarView.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI

struct AvatarView: View {
    let url: URL?
    let width: Double
    let height: Double

    init(url: URL?, width: Double = 120, height: Double = 120) {
        self.url = url
        self.width = width
        self.height = height
    }

    var body: some View {
        AsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
            case .failure:
                Image(systemName: "wifi.slash")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
        .background(Color.gray)
        .clipShape(Circle())
    }
}
