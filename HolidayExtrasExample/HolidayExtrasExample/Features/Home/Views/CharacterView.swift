//
//  CharacterView.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI

struct CharacterViewItem: Identifiable {
    let id: Int
    let name: String
    let species: String
    let gender: String
    let status: String
    let imageUrl: URL?
}

struct CharacterView: View {

    private let item: CharacterViewItem

    init(item: CharacterViewItem) {
        self.item = item
    }

    var body: some View {
        VStack {
            AvatarView(url: item.imageUrl)

            Text(item.name)
                .font(.title)
                .bold()
                .padding()
        }
    }
}
