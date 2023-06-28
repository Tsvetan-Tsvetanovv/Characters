//
//  CharacterView.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI

struct CharacterViewItem {
    let name: String
    let species: String
    let gender: String
    let status: String
    let imageUrl: URL?
}

struct CharacterView: View {

    private let item: Character

    init(item: Character) {
        self.item = item
    }

    var body: some View {
        VStack {
            AvatarView(url: URL(string: item.image))

            Text(item.name)
                .font(.title)
                .bold()
                .padding()
        }
    }
}
